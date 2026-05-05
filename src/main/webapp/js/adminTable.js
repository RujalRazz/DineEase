'use strict';

function initSearchBar(inputId, tableId) {
    const input = document.getElementById(inputId);
    const table = document.getElementById(tableId);
    if (!input || !table) return;

    input.addEventListener('keyup', () => {
        const query = input.value.toLowerCase().trim();
        const rows = table.querySelectorAll('tbody tr');

        rows.forEach(row => {
            // Check all td cells in the row
            const text = Array.from(row.querySelectorAll('td'))
                .map(td => td.textContent.toLowerCase())
                .join(' ');

            row.style.display = text.includes(query) ? '' : 'none';
        });

        // Show empty state if all rows hidden
        updateEmptyState(table);
    });
}
function initCityFilter(selectId, tableId) {
    const select = document.getElementById(selectId);
    const table = document.getElementById(tableId);
    if (!select || !table) return;

    select.addEventListener('change', () => {
        const selected = select.value.toLowerCase().trim();
        const rows = table.querySelectorAll('tbody tr');

        rows.forEach(row => {
            if (selected === '' || selected === 'all') {
                row.style.display = '';
            } else {
                const cityCell = row.getAttribute('data-city') || '';
                row.style.display =
                    cityCell.toLowerCase() === selected ? '' : 'none';
            }
        });

        updateEmptyState(table);
    });
}
function initDateFilter(inputId, clearBtnId, tableId) {
    const input = document.getElementById(inputId);
    const clearBtn = document.getElementById(clearBtnId);
    const table = document.getElementById(tableId);
    if (!input || !table) return;

    input.addEventListener('change', () => applyDateFilter());

    if (clearBtn) {
        clearBtn.addEventListener('click', () => {
            input.value = '';
            applyDateFilter();
        });
    }

    function applyDateFilter() {
        const selected = input.value.trim();
        const rows = table.querySelectorAll('tbody tr');

        rows.forEach(row => {
            if (!selected) {
                row.style.display = '';
            } else {
                const rowDate = row.getAttribute('data-date') || '';
                row.style.display = rowDate === selected ? '' : 'none';
            }
        });

        updateEmptyState(table);
    }
}
function initColumnSort(tableId) {
    const table = document.getElementById(tableId);
    if (!table) return;

    // Track sort state per column
    const sortState = {};

    table.querySelectorAll('thead th[data-col]').forEach(th => {
        th.style.cursor = 'pointer';
        th.title = 'Click to sort';

        // Add sort indicator
        const indicator = document.createElement('span');
        indicator.className = 'sort-indicator';
        indicator.textContent = ' ⇅';
        indicator.style.cssText =
            'font-size:11px;color:#c0392b;opacity:0.5;margin-left:4px;';
        th.appendChild(indicator);

        th.addEventListener('click', () => {
            const colIndex = parseInt(th.getAttribute('data-col'));
            const isNumeric = th.getAttribute('data-type') === 'number';

            // Toggle direction
            sortState[colIndex] = sortState[colIndex] === 'asc' ? 'desc' : 'asc';
            const direction = sortState[colIndex];

            // Update all indicators
            table.querySelectorAll('thead th .sort-indicator').forEach(ind => {
                ind.textContent = ' ⇅';
                ind.style.opacity = '0.5';
            });
            indicator.textContent = direction === 'asc' ? ' ↑' : ' ↓';
            indicator.style.opacity = '1';

            // Sort the rows
            const tbody = table.querySelector('tbody');
            const rows = Array.from(tbody.querySelectorAll('tr'));

            rows.sort((a, b) => {
                const aCell = a.querySelectorAll('td')[colIndex];
                const bCell = b.querySelectorAll('td')[colIndex];
                const aText = aCell ? aCell.textContent.trim() : '';
                const bText = bCell ? bCell.textContent.trim() : '';

                if (isNumeric) {
                    const aNum = parseFloat(aText.replace(/[^0-9.-]/g, '')) || 0;
                    const bNum = parseFloat(bText.replace(/[^0-9.-]/g, '')) || 0;
                    return direction === 'asc' ? aNum - bNum : bNum - aNum;
                } else {
                    return direction === 'asc'
                        ? aText.localeCompare(bText)
                        : bText.localeCompare(aText);
                }
            });


            rows.forEach(row => tbody.appendChild(row));
        });
    });
}
function initCombinedFilter(config) {
    const {
        searchId,
        citySelectId,
        dateInputId,
        clearDateId,
        tableId
    } = config;

    const table = document.getElementById(tableId);
    if (!table) return;

    function applyAllFilters() {
        const searchEl = document.getElementById(searchId);
        const searchVal = searchEl ? searchEl.value.toLowerCase().trim() : '';

        const cityEl = document.getElementById(citySelectId);
        const cityVal = cityEl ? cityEl.value.toLowerCase().trim() : '';

        const dateEl = document.getElementById(dateInputId);
        const dateVal = dateEl ? dateEl.value.trim() : '';

        const rows = table.querySelectorAll('tbody tr');
        rows.forEach(row => {
            const text = Array.from(row.querySelectorAll('td'))
                .map(td => td.textContent.toLowerCase())
                .join(' ');

            const rowCity = (row.getAttribute('data-city') || '').toLowerCase();
            const rowDate = row.getAttribute('data-date') || '';

            const matchSearch = !searchVal || text.includes(searchVal);
            const matchCity = !cityVal || cityVal === 'all' || rowCity === cityVal;
            const matchDate = !dateVal || rowDate === dateVal;

            row.style.display = (matchSearch && matchCity && matchDate) ? '' : 'none';
        });

        updateEmptyState(table);
    }

    const searchInput = document.getElementById(searchId);
    const citySelect = document.getElementById(citySelectId);
    const dateInput = document.getElementById(dateInputId);
    const clearBtn = document.getElementById(clearDateId);

    if (searchInput) searchInput.addEventListener('keyup', applyAllFilters);
    if (citySelect) citySelect.addEventListener('change', applyAllFilters);
    if (dateInput) dateInput.addEventListener('change', applyAllFilters);

    if (clearBtn) {
        clearBtn.addEventListener('click', () => {
            if (dateInput) dateInput.value = '';
            applyAllFilters();
        });
    }
    function updateEmptyState(table) {
        const tbody = table.querySelector('tbody');
        const visibleRows = Array.from(tbody.querySelectorAll('tr'))
            .filter(r =>
                r.style.display !== 'none' &&
                !r.classList.contains('no-results-row')
            );


        const existing = tbody.querySelector('.no-results-row');
        if (existing) existing.remove();


        if (visibleRows.length === 0) {
            const colspan = table.querySelectorAll('thead th').length;
            const noRow = document.createElement('tr');
            noRow.className = 'no-results-row';
            noRow.innerHTML = `
            <td colspan="${colspan}"
                style="text-align:center;padding:40px;color:#bbb;font-size:14px;">
                &#128269; No results match your search or filter.
            </td>`;
            tbody.appendChild(noRow);
        }
    }
}
