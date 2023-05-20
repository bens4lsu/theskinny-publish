function showHide(rowID, imgID)
{
	if (rowID.style.display == 'none') {
		rowID.style.display = '';
		imgID.src = '/img/downarrow.gif';
	}
	else{
		rowID.style.display = 'none';
		imgID.src = '/img/rightarrow.gif';
	}
}
