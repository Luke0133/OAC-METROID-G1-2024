//colar no console do hook theory
(async () => {
    const noteTable = {
      '1': 72,
      '#1': 73,
      '1s': 73,
      '1f': 73,
      'b1': 73,
      'b2': 73,
      '2': 74,
      '#2': 75,
      '2s': 75,
      '2f': 75,
      'b3': 75,
      '3': 76,
      '#3': 76,
      '3s': 76,
      '3f': 76,
      'b4': 76,
      '4': 77,
      '#4': 78,
      '4s': 78,
      '4f': 78,
      'b5': 78,
      '5': 79,
      '#5': 80,
      '5s': 80,
      '5f': 80,
      'b6': 80,
      '6': 81,
      '#6': 82,
      '6s': 82,
      '6f': 82,
      'b7': 82,
      '7': 83,
      '7f': 85,
      '7s': 85,
      '#7': 85
    }
  
    const parseJSONNotes = (data) => {
      const { tempos: [ { bpm } ] } = data
      const tempo = Math.round(60000 / bpm)
      let position = data.notes[0].beat
      let notes = []
      for (let i = 0; i < data.notes.length; i++) {
        const cn = data.notes[i]
        if (position !== cn.beat) {
          const diff = cn.beat - position
          notes[i-1][1] += Math.floor(diff * tempo)
          position += diff
        }
        const octave = cn.octave
        const note = Math.floor(noteTable[cn.sd] + 12 * (isNaN(octave) ? 0 : octave - 1))
        if (isNaN(note)) alert(`Erro ao processar nota ${i} (octave ${cn.octave}): ${cn.sd}`)
        notes[i] = [note, Math.floor(cn.duration * tempo)]
        position += cn.duration
      }
      notes = notes.flat().join(',')
      return [ notes.split(',').length / 2, notes ]
    }
  
    const parseXMLNotes = (data) => {
      const getKey = (n, key) => n.querySelector(key).textContent
      const bpm = parseInt(getKey(data, 'BPM') || getKey(data, 'bpm'))
      const n = [...data.querySelectorAll('note')]
      const tempo = Math.round(60000 / bpm)
      let position = 0
      let notes = []
      for (let i = 0; i < n.length; i++) {
        const cn = n[i]
        const isRest = Boolean(Number(getKey(cn, 'isRest')))
        const duration = parseFloat(getKey(cn, 'note_length'))
        if (isRest) {
          if (i > 0 && notes[i-1]) {
            notes[i-1][1] += Math.floor(duration * tempo)
          }
        } else {
          const sd = getKey(cn, 'scale_degree')
          const octave = parseInt(getKey(cn, 'octave'))
  
          const note = noteTable[sd] + 12 * (isNaN(octave) ? 0 : octave - 1)
          if (isNaN(note)) alert(`Erro ao processar nota ${i} (octave ${cn.octave}): ${sd}`)
          notes[i] = [note, Math.floor(duration * tempo)]
          position += duration
        }
      }
      notes = notes.flat().join(',')
      return [ notes.split(',').length / 2, notes ]
    }
  
    const createNotes = async (id) => {
      const json = await fetch(`https://api.hooktheory.com/v1/songs/public/${id}?fields=ID,xmlData,song,jsonData,bpm`).then(r => r.json())
      if (json.xmlData) {
        const xmlDocument = (new DOMParser()).parseFromString(json.xmlData.replace(/%20/gi, ''), 'text/xml')
        return parseXMLNotes(xmlDocument)
      }
      return parseJSONNotes(JSON.parse(json.jsonData))
    }
  
    const links = document.querySelectorAll('.col-md-8>div h2>a')
    const parts = {}
    await Promise.all([...document.querySelectorAll(".col-md-8>.padding-bottom-20>div:nth-child(2)>a:not([href*='difficulties'])")].map(async (el, i) => {
      const url = new URL(links[i].href)
      parts[el.textContent.trim()] = await createNotes(url.searchParams.get('idOfSong'))
    }))
    console.group(Object.entries(parts).map(([ k, v ]) => `${k}\nTAMANHO: ${v[0]}\nNOTAS: ${v[1]}`).join('\n\n\n'))
  })()