class PrepareCampusData:
        
    def __init__(self, filename):
            self.filename = filename
            self.data = self.load_data()
            
    def load_data(self):
        # Assume this method loads the dataset from a CSV file
        # and returns it as a pandas DataFrame
        import pandas as pd
        return pd.read_csv(self.filename)
    
    def clean_data(self, df):
        """
        Takes a DataFrame and rearranges columns to match the correct format for school visualizations.
        """
        import pandas as pd
        # filter down to 4 and 5 
        df["erss_enroll_stat"].isin([4, 5])
        # more code to reformat the columns and do feature engineering
        return pd.read_csv(self.filename)
