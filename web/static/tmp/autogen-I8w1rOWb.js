$('input[id=hident2]').change((ev)=>document.getElementById('assemblyInput').readOnly=true);function checkTextArea(value){var emptyText=value!='';document.getElementById('hident2').disabled=emptyText}