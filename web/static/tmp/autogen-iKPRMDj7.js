$('input[id=hident2]').change((ev)=>document.getElementById('assemblyInput').readOnly=true);$('input[id=assemblyInput]').change((_)=>console.log('hey'))