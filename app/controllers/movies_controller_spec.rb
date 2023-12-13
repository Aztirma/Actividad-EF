Describe MoviesController do
    describe 'searching TMDb' do
        it 'calls Tmdb::Movie.search with the provided search term' do
        allow(Tmdb::Movie).to receive(:search)
        
        get :search_tmdb, params: { search_term: 'Inception' }
        
        expect(Tmdb::Movie).to have_received(:search).with('Inception')
        end

        it 'renders the search_tmdb template' do
        get :search_tmdb, params: { search_term: 'Inception' }
        
        expect(response).to render_template('search_tmdb')
        end

        it 'assigns the TMDb search results to @movies' do
        movie_results = [{'title' => 'Inception', 'id' => 123}]
        allow(Tmdb::Movie).to receive(:search).with('Inception').and_return(movie_results)
        
        get :search_tmdb, params: { search_term: 'Inception' }
        
        expect(assigns(:movies)).to eq(movie_results)
        end

        it 'redirects to root_path if search term is blank' do
        get :search_tmdb, params: { search_term: '' }
        
        expect(flash[:alert]).to eq('Please enter a search term')
        expect(response).to redirect_to(root_path)
        end
    end
end