import pandas as pd
import arrays.operations as array_operations
import numpy as np


def filter_outliers(
    dataframe: pd.DataFrame,
    column: str,
    std: float = 2
) -> pd.DataFrame:
    """
        Filter a pandas dataframe based on outliers of a column
    """
    series = dataframe[column].to_numpy(dtype=np.float32)
    bool_series: np.ndarray = array_operations.array_operations.remove_outliers(
        vector=series, lenx=len(series), std_in=std).astype(dtype=np.bool)

    filtered_dataframe = dataframe[bool_series]
    return filtered_dataframe
