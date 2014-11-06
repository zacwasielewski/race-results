$(document).ready(function(){

	var table = $('.table.race_runners');
	
	if (table.size() > 0) {

		$('.pagination').hide();
		$('.runner_search').hide();

		table.DataTable({
			processing: true,
			serverSide: true,
			ajax: table.data('source'),
			columns: [
				{ data: 'place' },
				{ data: 'name' },
				{ data: 'sex' },
				{ data: 'group' },
				{ data: 'time' },
				{ data: 'pace' },
				{ data: 'location' }
			],
			sorting: [[ 0, 'asc' ]],
		});

	}

});
