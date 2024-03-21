const svgWrap = document.createElement('div'),
    svgData = `

  	<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  
		<symbol id="icon-adobe-reader-symbol" viewBox="0 0 512 512">
		  <path d="m508 375c-19-33-98-54-169-58-6-7-13-14-19-21-61-70-85-170-94-224-2-11-3-20-4-27-1-6-2-17-14-17-4 0-8 1-11 4-4 5-3 10-3 17 1 7 3 16 4 27 6 54 8 157-34 239-4 8-8 16-13 24-78 23-140 63-150 97-3 12 0 24 9 33 10 10 21 15 35 15 37 0 79-41 125-122 20-5 41-9 60-11 8-1 20-2 28-3 21-4 45-5 69-4 57 59 103 88 137 88 19 0 34-9 44-25 5-10 5-22 0-32z m-463 82c-6 0-11-2-16-7-2-2-2-4-1-7 4-17 44-47 103-68-33 52-65 82-86 82z m209-136c-8 1-19 2-27 3-13 1-26 4-40 6 0-1 1-2 2-3 20-40 33-88 37-143 19 52 44 96 73 130 1 1 2 2 3 3-17 0-33 1-48 4z m230 73c-5 8-11 11-20 11l0 0c-22 0-55-20-95-58 62 8 107 27 115 41 1 2 1 3 0 6z"/>
		</symbol>
	  
		<symbol id="icon-apple" viewBox="0 0 512 512">
		  <path d="m68 188c-43 75-15 189 32 258 24 35 49 66 82 66 0 0 1 0 2 0 15-1 26-5 37-10 12-5 25-11 45-11 19 0 31 6 42 11 12 5 24 10 41 9 37 0 60-34 81-63 21-31 31-61 35-73l0 0c1-2 0-4-2-5 0 0 0 0-1 0-6-3-64-29-64-98-1-57 43-87 52-92l0-1c1 0 2-1 2-2 0-1 0-3-1-3-30-45-76-51-95-52-3 0-5-1-8-1-22 0-43 9-60 15-12 5-22 9-29 9-8 0-18-4-29-9-16-6-34-13-53-13 0 0 0 0-1 0-44 1-85 26-108 65z m288-188c-26 1-58 17-77 40-16 18-32 49-28 81 0 2 2 3 4 3 2 1 4 1 5 1 26 0 54-15 73-38 20-24 30-55 27-83 0-2-2-4-4-4z"/>
		</symbol>
	  
		<symbol id="icon-bitcoin-1" viewBox="0 0 512 512">
		  <path d="m332 225c0-25-20-45-45-45l-15 0 0-15c0-8-7-15-15-15-8 0-15 7-15 15l0 15-45 0c-8 0-15 7-15 15 0 8 7 15 15 15l15 0 0 90-15 0c-8 0-15 7-15 15 0 8 7 15 15 15l45 0 0 15c0 8 7 15 15 15 8 0 15-7 15-15l0-15 15 0c25 0 45-20 45-45 0-11-4-22-11-30 7-8 11-18 11-30z m-45 75l-45 0 0-30 45 0c8 0 15 7 15 15 0 8-7 15-15 15z m0-60l-45 0 0-30 45 0c8 0 15 7 15 15 0 8-7 15-15 15z"/>
		</symbol>
	  
		<symbol id="icon-bitcoin-2" viewBox="0 0 512 512">
		  <path d="m452 171l-85 0c-5 0-9 3-9 8 0 5 4 9 9 9l77 0 0 222-376 0 0-222 77 0c5 0 9-4 9-9 0-5-4-8-9-8l-85 0c-5 0-9 3-9 8l0 239c0 5 4 9 9 9l392 0c5 0 9-4 9-9l0-239c0-5-4-8-9-8z m43 273l0-282c0-14-12-25-26-25l-85 0c-5 0-9 3-9 8 0 5 4 9 9 9l85 0c5 0 9 3 9 8l0 282-188 0 0 8c0 5-4 9-8 9l-52 0c-4 0-8-4-8-9l0-8-188 0 0-282c0-5 4-8 9-8l85 0c5 0 9-4 9-9 0-5-4-8-9-8l-85 0c-14 0-26 11-26 25l0 282-17 0 0 25c0 24 19 43 43 43l426 0c24 0 43-19 43-43l0-25z m0 25c0 14-12 26-26 26l-426 0c-14 0-26-12-26-26l0-8 189 0c0 0 1 0 1 1 0 0 0 1 0 1 1 1 1 2 2 3 0 0 0 1 1 1 0 1 1 2 2 3 0 0 0 0 0 0 1 2 3 2 4 3 0 1 1 1 1 1 1 1 2 1 3 2 0 0 1 0 1 0 1 1 2 1 3 1 1 0 1 0 2 0 1 1 3 1 4 1l52 0c1 0 3 0 4-1 1 0 1 0 2 0 1 0 2-1 3-1 0 0 1 0 1 0 1-1 2-1 3-2 0 0 1 0 1-1 1-1 3-2 4-3 0 0 0 0 0 0 1-1 2-2 2-3 1 0 1-1 1-1 1-1 1-2 2-3 0 0 0-1 0-1 0-1 1-1 1-1l189 0z m-204-371c12-14 10-36-5-48-4-3-8-5-13-6l0-10c0-5-4-8-8-8-5 0-9 3-9 8l0 9-9 0 0-9c0-5-3-8-8-8-5 0-9 3-9 8l0 9-25 0c-5 0-9 3-9 8 0 5 4 9 9 9l8 0 0 102-8 0c-5 0-9 4-9 9 0 4 4 8 9 8l25 0 0 9c0 4 4 8 9 8 5 0 8-4 8-8l0-9 9 0 0 9c0 4 4 8 9 8 4 0 8-4 8-8l0-9c24 0 43-19 43-42 0-17-10-32-25-39z m-61-38l35 0c9 0 17 7 17 17 0 9-8 17-17 17l-35 0z m43 102l-43 0 0-51 43 0c14 0 26 11 26 26 0 14-12 25-26 25z m-17-162c-61 0-111 50-111 111 0 61 50 111 111 111 61 0 111-50 111-111 0-61-50-111-111-111z m0 205c-52 0-94-42-94-94 0-52 42-94 94-94 52 0 94 42 94 94 0 52-42 94-94 94z m97 76l-40-40c-3-3-8-3-12 0l-40 40c-3 4-3 9 1 12 3 3 8 3 11 0l26-25 0 107c0 5 3 9 8 9 5 0 9-4 9-9l0-107 25 25c3 4 9 3 12 0 3-3 3-9 0-12z m-103 49c-3-3-8-3-11 0l-26 25 0-108c0-4-3-8-8-8-5 0-9 4-9 8l0 108-25-25c-3-4-9-3-12 0-3 3-3 8 0 12l40 40c3 3 9 3 12 0l40-40c3-4 3-9-1-12z"/>
		</symbol>
	  
		<symbol id="icon-bitcoin-on-ball" viewBox="0 0 512 512">
		  <path d="m439 183c0-61-49-110-110-110l-36 0 0-36c0-21-17-37-37-37-20 0-37 16-37 37l0 36-109 0c-20 0-37 17-37 37 0 20 17 36 37 36l36 0 0 220-36 0c-20 0-37 16-37 36 0 20 17 37 37 37l109 0 0 36c0 21 17 37 37 37 20 0 37-16 37-37l0-36 36 0c43 0 83-26 100-65 18-40 11-86-18-118 18-20 28-46 28-73z m-110 183l-110 0 0-73 110 0c20 0 37 16 37 36 0 20-17 37-37 37z m0-147l-110 0 0-73 110 0c20 0 37 17 37 37 0 20-17 36-37 36z"/>
		</symbol>
	  
		<symbol id="icon-calendar" viewBox="0 0 512 512">
		  <path d="m187 283c0-7-6-12-12-12l-41 0c-6 0-11 5-11 12l0 40c0 7 5 12 11 12l41 0c6 0 12-5 12-12z m101 0c0-7-5-12-12-12l-40 0c-7 0-12 5-12 12l0 40c0 7 5 12 12 12l40 0c7 0 12-5 12-12z m101 0c0-7-5-12-11-12l-41 0c-6 0-11 5-11 12l0 40c0 7 5 12 11 12l41 0c6 0 11-5 11-12z m-202 101c0-6-6-12-12-12l-41 0c-6 0-11 6-11 12l0 41c0 6 5 11 11 11l41 0c6 0 12-5 12-11z m101 0c0-6-5-12-12-12l-40 0c-7 0-12 6-12 12l0 41c0 6 5 11 12 11l40 0c7 0 12-5 12-11z m101 0c0-6-5-12-11-12l-41 0c-6 0-11 6-11 12l0 41c0 6 5 11 11 11l41 0c6 0 11-5 11-11z m73-327l0 62c0 28-23 51-51 51l-32 0c-28 0-51-23-51-51l0-62-144 0 0 62c0 28-23 51-51 51l-32 0c-28 0-51-23-51-51l0-62c-24 1-44 21-44 46l0 363c0 25 20 46 46 46l409 0c25 0 45-21 45-46l0-363c0-25-20-45-44-46z m-15 386c0 11-9 20-20 20l-343 0c-11 0-20-9-20-20l0-187c0-11 9-20 20-20l343 0c11 0 20 9 20 20z m-346-307l32 0c9 0 17-7 17-17l0-102c0-9-8-17-17-17l-32 0c-10 0-18 8-18 17l0 102c0 10 8 17 18 17z m278 0l31 0c10 0 18-7 18-17l0-102c0-9-8-17-18-17l-31 0c-10 0-18 8-18 17l0 102c0 10 8 17 18 17z"/>
		</symbol>
	  
		<symbol id="icon-circular-clock" viewBox="0 0 512 512">
		  <path d="m187 358l64-53c2 0 4 1 6 1 26 0 48-21 48-47 0-15-8-28-19-36l-9-116c0-9-6-16-15-18-11-2-21 6-22 17l-9 117c-12 8-19 22-19 38 1 2 1 4 1 6l-52 64c-6 6-7 16-2 23 7 9 19 11 28 4z m72-117c10 0 18 8 18 18 0 11-8 19-18 19-11 0-19-8-19-19 0-10 8-18 19-18z m-3 271c141 0 256-115 256-256 0-141-115-256-256-256-141 0-256 115-256 256 0 141 115 256 256 256z m0-452c108 0 196 88 196 196 0 108-88 196-196 196-108 0-196-88-196-196 0-108 88-196 196-196z"/>
		</symbol>
	  
		<symbol id="icon-circumference" viewBox="0 0 512 512">
		  <path d="m256 71c49 0 95 19 130 54 35 35 54 81 54 131 0 49-19 95-54 130-35 35-81 54-130 54-50 0-96-19-131-54-35-35-54-81-54-130 0-50 19-96 54-131 35-35 81-54 131-54m0-71c-141 0-256 115-256 256 0 141 115 256 256 256 141 0 256-115 256-256 0-141-115-256-256-256z"/>
		</symbol>
	  
		<symbol id="icon-close-cross" viewBox="0 0 512 512">
		  <path d="m341 255l150-151c24-24 24-62 0-86-24-24-62-24-86 0l-150 150-151-150c-24-24-62-24-86 0-24 24-24 62 0 86l150 151-150 150c-24 24-24 62 0 86 12 12 27 18 43 18 16 0 31-6 43-18l151-150 150 150c12 12 27 18 43 18 16 0 31-6 43-18 24-24 24-62 0-86z"/>
		</symbol>
	  
		<symbol id="icon-github" viewBox="0 0 512 512">
		  <path d="m256 5c-141 0-256 115-256 257 0 114 73 210 175 244 13 3 18-5 18-12 0-6-1-22-1-44-71 16-86-34-86-34-12-30-28-38-28-38-24-16 1-16 1-16 26 2 39 27 39 27 23 39 60 28 75 21 2-16 9-28 16-34-57-7-116-29-116-127 0-28 10-51 26-69-3-7-11-33 3-68 0 0 21-7 70 26 20-5 42-8 64-8 22 0 44 3 64 8 49-33 70-26 70-26 14 35 6 61 3 68 16 18 26 41 26 69 0 99-60 120-117 127 10 8 18 23 18 47 0 35 0 62 0 71 0 7 4 15 17 12 102-34 175-130 175-244 0-142-115-257-256-257z"/>
		</symbol>
	  
		<symbol id="icon-group" viewBox="0 0 512 512">
		  <path d="m511 446l-20-71c-1-1-2-3-3-4-12-38-43-67-82-78l-6-1c-9-2-19 1-25 8-21 24-48 26-77 26-28 0-55-2-76-26-7-7-16-10-25-8l-6 2c-29 8-55 27-70 52l-61 0c-1 0-1 0-1-1 0 0-1-1-1-2l13-45c11-35 32-46 74-56 2-1 3-2 4-3 3 3 7 6 11 8 2 1 3 1 4 1 4 0 7-2 9-6 3-5 1-10-4-13-22-11-38-44-38-78 0-30 24-55 54-55 6 0 11 1 17 3-6 13-9 27-9 42 0 82 50 152 109 152 58 0 109-71 109-152 0-61-48-109-109-109-38 0-72 19-91 49-8-3-17-4-26-4-26 0-49 14-62 35-1-1-2-2-3-2-7-4-14-5-23-5-27-1-48 21-48 48 0 15 4 30 11 41-23 6-42 15-52 44l-7 28c-2 5-1 11 2 14 3 5 8 7 14 7l37 0c-1 2-2 4-2 6l-13 45c-2 7 0 13 4 19 4 5 10 8 17 8l51 0c-2 3-3 7-4 10l-20 71c-2 8 0 17 5 24 5 7 13 10 21 10l372 0c8 0 16-3 21-10 5-7 7-16 5-24z m-289-346c1 0 1-1 2-2 0 0 0-1 1-2 15-27 44-45 77-45 40 0 74 26 86 63-17 3-35-4-46-18-3-5-9-6-13-2-2 1-3 3-4 5 0 0 0 1-1 1-13 28-59 39-110 29 1-10 4-20 8-29z m28 52c38 0 70-12 87-35 12 11 27 16 43 16 3 0 8 0 12-1 0 3 0 5 0 8 0 71-42 134-90 134-46 0-86-58-89-126 12 3 25 4 37 4z m-230 116l7-24c6-20 18-26 42-32 2 0 3-1 4-2 3 2 5 4 7 5 2 1 3 1 5 1 3 0 7-2 8-5 3-5 1-11-3-13-13-7-22-26-22-45 0-17 13-30 29-30 6 0 10 1 14 4 2 0 3 1 4 1-2 7-4 15-4 23 0 27 10 55 24 73-29 8-55 17-72 44z m471 190c-1 1-3 3-6 3l-372 0c-3 0-5-2-6-3-1-2-2-5-1-7l20-70c9-33 36-60 70-68l6-2c1 0 4 1 5 2 27 31 59 33 91 33 32 0 65-2 92-33 1-1 3-2 5-2l6 2c34 8 61 35 70 68l9 30c1 1 1 2 2 3l11 37c0 2 0 5-2 7z"/>
		</symbol>
	  
		<symbol id="icon-hacker" viewBox="0 0 512 512">
		  <path d="m392 402c0-10-5-19-13-24l0-7c0-6-4-10-10-10-5 0-10 4-10 10l0 3-5 0 0-3c0-6-5-10-10-10-6 0-10 4-10 10l0 3-6 0c-6 0-10 4-10 10 0 6 4 10 10 10l2 0 0 52-2 0c-6 0-10 4-10 10 0 6 4 10 10 10l6 0 0 3c0 6 4 10 10 10 5 0 10-4 10-10l0-3 5 0 0 3c0 6 5 10 10 10 6 0 10-4 10-10l0-7c8-5 13-14 13-24 0-7-2-13-6-18 4-5 6-11 6-18z m-28 44l-14 0 0-16 14 0c5 0 8 4 8 8 0 4-3 8-8 8z m0-36l-14 0 0-16 14 0c5 0 8 4 8 8 0 4-3 8-8 8z m-101-69c-2-2-4-3-7-3-3 0-5 1-7 3-2 1-3 4-3 7 0 2 1 5 3 7 2 2 4 3 7 3 3 0 5-1 7-3 2-2 3-5 3-7 0-3-1-6-3-7z m239 151l-44 0 0-85c0-50-36-93-85-103-4-1-8-5-8-10l0-68c0-4-2-7-6-9-1-1-3-1-5-1l0-49 21 0c18 0 32-14 32-32 0-17-14-31-32-31l-13 0 0-60c0-17-9-31-23-39-14-7-31-7-45 2l-25 17c-8 5-18 5-26 0l-25-17c-14-9-31-9-45-2-14 8-23 22-23 39l0 60-13 0c-18 0-32 14-32 31 0 18 14 32 32 32l21 0 0 49c-2 0-4 0-5 1-4 2-6 5-6 9l0 68c0 5-4 9-8 10l-17 3c-39 8-68 43-68 83l0 102-44 0c-5 0-10 4-10 10 0 6 5 10 10 10l492 0c6 0 10-4 10-10 0-6-4-10-10-10z m-332-400l75 0c6 0 10-4 10-10 0-5-4-10-10-10l-75 0 0-28c0-9 5-17 12-21 8-4 17-4 25 1l25 17c15 9 33 9 48 0l25-17c8-5 17-5 25-1 7 4 12 12 12 21l0 60-172 0z m-33 55c-7 0-12-5-12-12 0-6 5-11 12-11l238 0c7 0 12 5 12 11 0 7-5 12-12 12z m113 20l70 0-47 47-10-11c-4-4-10-4-14 0l-13 13-35 0z m-1 0l1 0c-1 0-1 0-1 0z m-71 44l0-44 44 0z m62 25c3 0 5-1 7-3l9-8 8 8c2 2 5 3 7 3l56 0-71 60-71-60z m60-20l34-34 0 34z m-34 276l0-104c0-6-4-10-10-10-6 0-10 4-10 10l0 104-172 0 0-102c0-31 22-57 52-63l16-3c3-1 5-1 7-2l39 39c2 2 4 3 7 3 3 0 5-1 7-3 4-4 4-11 0-14l-39-39c3-4 4-9 4-14l0-47 83 70c3 3 9 3 12 0l83-70 0 47c0 4 1 8 3 12l-44 44c-4 4-4 10 0 14 2 2 5 3 7 3 3 0 5-1 7-3l43-43c3 1 6 2 9 3 39 8 68 43 68 83l0 85-172 0z m23-417c-2-2-5-3-8-3-2 0-5 1-7 3-1 2-3 4-3 7 0 3 2 5 3 7 2 2 5 3 7 3 3 0 6-1 8-3 1-2 2-4 2-7 0-3-1-5-2-7z"/>
		</symbol>
	  
		<symbol id="icon-if-59-play-843782" viewBox="0 0 512 512">
		  <path d="m353 162l-239-128c-13-7-26-7-38-3l204 204z m90 48l-69-37-78 78 78 78 69-37c32-18 32-64 0-82z m-385-166c-8 8-12 19-12 31l0 352c0 12 4 23 12 31l207-207z m18 427c12 4 25 3 38-3l239-128-73-73z"/>
		</symbol>
	  
		<symbol id="icon-if-cryptocurrency-blockchain-dash-dash-2909603" viewBox="0 0 512 512">
		  <path d="m256 472c-119 0-216-97-216-216 0-119 97-216 216-216 119 0 216 97 216 216 0 119-97 216-216 216z m0-424c-115 0-208 93-208 208 0 115 93 208 208 208 115 0 208-93 208-208 0-115-93-208-208-208z m0 392c-101 0-184-83-184-184 0-101 83-184 184-184 101 0 184 83 184 184 0 101-83 184-184 184z m0-360c-97 0-176 79-176 176 0 97 79 176 176 176 97 0 176-79 176-176 0-97-79-176-176-176z m51 256l-177 0 15-48 155 0 22-64-155 0 15-48 173 0c6 0 12 2 15 4 5 2 9 6 12 11 2 4 3 9 4 14 1 6 0 12-3 17l-22 71c-2 6-5 11-8 15-4 6-9 10-13 14-5 4-11 7-16 10l-1 0c-5 2-10 4-16 4z m-166-8l166 0c4 0 9-2 13-3l1-1c4-2 9-5 14-9 4-3 8-7 11-12 3-3 5-8 7-13l23-71c2-4 2-9 2-13-1-4-2-8-3-11-2-4-5-6-8-7-3-2-7-4-12-4l-168 0-9 32 155 0-27 80-155 0z m84-48l-100 0 14-48 100 0z m-90-8l84 0 9-32-83 0z"/>
		</symbol>
	  
		<symbol id="icon-if-cryptocurrency-blockchain-ethereum-eth-2909601" viewBox="0 0 512 512">
		  <path d="m256 472c-119 0-216-97-216-216 0-119 97-216 216-216 119 0 216 97 216 216 0 119-97 216-216 216z m0-424c-115 0-208 93-208 208 0 115 93 208 208 208 115 0 208-93 208-208 0-115-93-208-208-208z m0 392c-101 0-184-83-184-184 0-101 83-184 184-184 101 0 184 83 184 184 0 101-83 184-184 184z m0-360c-97 0-176 79-176 176 0 97 79 176 176 176 97 0 176-79 176-176 0-97-79-176-176-176z m0 44l79 132-79 47-79-47z m0-15l-90 150 90 53 90-53z m0 120l73 31-73 43-73-43z m0-8l-90 38 90 53 90-53z m62 81l-62 88-62-88 58 34 4 3 4-3z m28-26l-90 53-90-53 90 127 0 0z m-94-152l8 0 0 182-8 0z m0 207l8 0 0 63-8 0z"/>
		</symbol>
	  
		<symbol id="icon-if-cryptocurrency-blockchain-litecoin-ltc-2909599" viewBox="0 0 512 512">
		  <path d="m256 472c-119 0-216-97-216-216 0-119 97-216 216-216 119 0 216 97 216 216 0 119-97 216-216 216z m0-424c-115 0-208 93-208 208 0 115 93 208 208 208 115 0 208-93 208-208 0-115-93-208-208-208z m0 392c-101 0-184-83-184-184 0-101 83-184 184-184 101 0 184 83 184 184 0 101-83 184-184 184z m0-360c-97 0-176 79-176 176 0 97 79 176 176 176 97 0 176-79 176-176 0-97-79-176-176-176z m91 280l-195 0 19-67-27 11 11-44 27-10 33-122 78 0-24 91 35-13-11 43-35 14-13 49 117 0z m-184-8l178 0 10-32-116 0 16-63 35-14 6-24-34 13 25-96-62 0-32 121-27 9-6 24 27-11z"/>
		</symbol>
	  
		<symbol id="icon-if-cryptocurrency-blockchain-ripple-xrp-2909597" viewBox="0 0 512 512">
		  <path d="m256 472c-119 0-216-97-216-216 0-119 97-216 216-216 119 0 216 97 216 216 0 119-97 216-216 216z m0-424c-115 0-208 93-208 208 0 115 93 208 208 208 115 0 208-93 208-208 0-115-93-208-208-208z m0 392c-101 0-184-83-184-184 0-101 83-184 184-184 101 0 184 83 184 184 0 101-83 184-184 184z m0-360c-97 0-176 79-176 176 0 97 79 176 176 176 97 0 176-79 176-176 0-97-79-176-176-176z m46 301c-10 0-19-2-28-7-17-10-27-28-27-48 0-9 3-19 8-29 4-8 1-17-6-22-3-1-6-2-8-2-7 0-12 5-14 8-5 10-13 18-21 22-17 10-38 10-55 0-17-9-27-28-27-47 0-20 10-38 27-48 17-10 38-10 55 0 10 7 17 16 22 22 4 8 14 11 22 6 5-2 7-6 8-10 1-5-1-10-2-12-6-10-9-20-9-29 0-19 10-37 27-47 7-5 17-7 27-7 11 0 21 2 28 7 17 10 27 28 27 47 0 20-10 38-27 48-8 5-19 7-30 7-9 0-16 7-16 16 0 12 10 16 16 16 11 0 21 2 30 7 17 10 27 28 27 47 0 20-10 38-27 48-8 5-18 7-27 7z m-61-116c4 0 8 1 12 3 11 7 15 21 9 33-5 8-7 17-7 25 0 17 9 33 23 41 15 9 33 8 47 0 14-8 23-24 23-41 0-16-9-32-23-40-7-5-16-7-26-7-12 0-24-8-24-23 0-14 10-24 24-24 10 0 19-2 26-6 14-8 23-24 23-41 0-16-9-32-23-40-6-4-15-6-23-6 0 0 0 0 0 0-9 0-18 2-24 5-14 9-23 25-23 41 0 8 2 16 8 26 2 5 4 11 3 16-1 5-4 12-12 16-4 2-8 3-12 3-8 0-17-4-21-12-7-9-13-15-19-19-15-8-33-8-47 0-14 8-23 24-23 41 0 16 9 32 23 41 14 8 32 8 47 0 7-5 13-11 18-20 3-5 11-12 21-12z"/>
		</symbol>
	  
		<symbol id="icon-link" viewBox="0 0 512 512">
		  <path d="m28 512c8 0 15-3 20-8l76-76c23 15 50 24 78 24 0 0 0 0 0 0 38 0 74-15 101-42 0 0 0 0 0 0l53-54c0 0 0 0 0 0l54-53c0 0 0 0 0 0 27-27 42-63 42-101 0-28-9-55-24-78l76-76c11-11 11-29 0-40-11-11-29-11-40 0l-76 76c-23-15-50-24-78-24-38 0-74 15-101 42 0 0 0 0 0 0l-53 54c0 0 0 0 0 0l-54 53c0 0 0 0 0 0-48 49-54 124-18 179l-76 76c-11 11-11 29 0 40 6 5 13 8 20 8z m114-263c0 0 0 0 0 0l54-53c0 0 0 0 0 0l53-54c0 0 0 0 0 0 16-16 38-25 61-25 12 0 25 3 36 9l-43 43c-11 11-11 29 0 40 5 6 13 8 20 8 7 0 14-2 20-8l43-43c6 11 9 24 9 36 0 23-9 45-25 61l-54 53c0 0 0 0 0 0l-53 54c0 0 0 0 0 0-16 16-38 25-61 25-12 0-25-3-36-9l43-43c11-11 11-29 0-40-11-11-29-11-40 0l-43 43c-16-31-10-71 16-97z"/>
		</symbol>
	  
		<symbol id="icon-pinterest-letter-logo-in-a-circle" viewBox="0 0 512 512">
		  <path d="m256 0c-141 0-256 115-256 256 0 141 115 256 256 256 141 0 256-115 256-256 0-141-115-256-256-256z m169 265c-27 57-95 89-159 70 6 37-8 83-49 97-19 6-40 3-59-5-20-8-9-43-11-60 12 2 24 15 37 9 12-5 12-30 13-40 1-35-1-70-1-104 0-12 0-23 0-35 0-5 0-10 0-14 0-6 0-5 5-6 15-3 30-2 45-1 4 1 8 1 12 1 5 1 5 0 5 6 0 11 0 21 0 31 0 21 0 42 0 62 0 8 6 8 14 10 4 1 8 1 13 2 8 1 16 0 24-1 13-2 26-8 36-17 19-17 23-43 16-67-16-56-91-79-146-66-59 14-106 78-62 130-13 11-25 25-40 34-4 2-8 4-12 5-2-2-5-5-7-7-4-6-7-11-10-18-13-27-15-58-9-88 8-47 40-82 86-101 77-30 187-17 241 47 29 35 37 85 18 126z"/>
		</symbol>
	  
		<symbol id="icon-placeholder" viewBox="0 0 512 512">
		  <path d="m249 0c-102 4-187 83-196 184-2 21-1 40 2 59 0 0 1 2 2 6 3 15 8 28 14 41 20 48 67 130 174 218 6 5 16 5 22 0 107-88 154-169 174-218 6-13 11-26 14-41 1-4 2-6 2-6 2-13 3-26 3-39 0-115-95-208-211-204z m7 306c-55 0-99-45-99-99 0-55 44-100 99-100 55 0 99 45 99 100 0 54-44 99-99 99z"/>
		</symbol>
	  
		<symbol id="icon-resize" viewBox="0 0 512 512">
		  <path d="m512 348c0 0 0 0 0 0 0 0 0-1 0-1 0 0 0 0 0 0 0 0 0-1 0-1 0 0 0 0 0 0 0 0 0-1-1-1 0 0 0 0 0 0 0 0 0-1 0-1 0 0 0 0 0 0 0 0 0 0 0-1 0 0-1 0-1 0 0 0 0 0 0 0 0-1 0-1 0-1 0 0 0 0 0 0-1 0-1-1-1-1 0 0 0 0 0 0 0 0 0 0-1 0 0 0 0-1 0-1 0 0 0 0 0 0-1 0-1 0-1 0 0 0 0-1 0-1 0 0-1 0-1 0 0 0 0 0 0 0 0 0-1 0-1 0 0 0 0 0 0 0l-36-13c-6-2-12 1-14 6-2 6 1 12 7 14l15 5-32 13 0-173c0 0 0 0 0 0 0-1 0-1 0-1 0-5-3-9-7-10l-162-60 0-52 9 9c2 2 5 3 8 3 2 0 5-1 7-3 4-4 4-11 0-15l-25-26c0 0-1 0-1 0-2-2-5-3-7-3-3 0-6 1-8 3 0 0 0 0 0 0l-26 26c-4 4-4 11 0 15 2 2 5 3 8 3 2 0 5-1 7-3l7-7 0 51-154 59c0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0-1 0 0 0 0 0 0 1 0 0 0 0-1 0 0 0 0 0 0 0 0 0 0 0 0 1-1 0-1 0-1 0 0 0 0 0 0 0 0 0 0 0 0 0-1 1-1 1-1 1 0 0 0 0 0 0 0 0 0 1-1 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1-1 1-1 1 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0l0 182-55-17 19-8c6-2 8-8 6-14-2-5-9-8-14-5l-42 17c-1 1-2 1-3 2-5 2-7 8-5 13l17 43c2 4 6 6 10 6 2 0 3 0 4 0 6-3 8-9 6-14l-8-21 73 24c1 0 2 0 2 0l128 41c-1 2-1 4-1 6 0 19 15 34 34 34 18 0 33-15 33-34 0 0 0-1 0-2l104-40c0 0 0 0 0 0l82-32-2 9c-1 6 3 12 9 13 0 0 1 0 2 0 5 0 9-3 10-8l8-34c0 0 0 0 0 0 0-1 0-1 0-1 0 0 0 0 0-1 0 0 0 0 0 0 0 0 0 0 0-1z m-257 65c-4 2-8 4-11 7l-128-41 0-174 139 54z m0-177l-120-46 120-46z m21-93l128 47-128 47z m148 229l-133 51c-4-4-9-8-15-10l0-153 148-55z"/>
		</symbol>
	  
		<symbol id="icon-school-calendar" viewBox="0 0 512 512">
		  <path d="m458 62l-39 0 0-27c0-19-16-35-35-35l-2 0c-19 0-35 16-35 35l0 27-182 0 0-27c0-19-16-35-36-35l-1 0c-20 0-36 16-36 35l0 27-38 0c-20 0-36 16-36 35l0 379c0 20 16 36 36 36l404 0c20 0 35-16 35-36l0-379c0-19-15-35-35-35z m-24 394l-356 0 0-287 356 0z m-308-157l62 0c3 0 5-3 5-6l0-62c0-3-2-5-5-5l-62 0c-3 0-6 2-6 5l0 62c0 3 3 6 6 6z m99 0l62 0c3 0 5-3 5-6l0-62c0-3-2-5-5-5l-62 0c-3 0-6 2-6 5l0 62c0 3 3 6 6 6z m99 0l62 0c3 0 5-3 5-6l0-62c0-3-2-5-5-5l-62 0c-3 0-6 2-6 5l0 62c0 3 3 6 6 6z m-198 99l62 0c3 0 5-3 5-6l0-62c0-3-2-5-5-5l-62 0c-3 0-6 2-6 5l0 62c0 3 3 6 6 6z m99 0l62 0c3 0 5-3 5-6l0-62c0-3-2-5-5-5l-62 0c-3 0-6 2-6 5l0 62c0 3 3 6 6 6z m99 0l62 0c3 0 5-3 5-6l0-62c0-3-2-5-5-5l-62 0c-3 0-6 2-6 5l0 62c0 3 3 6 6 6z"/>
		</symbol>
	  
		<symbol id="icon-share" viewBox="0 0 512 512">
		  <path d="m416 325c-29 0-55 15-72 36l-159-81c2-8 4-16 4-24 0-9-2-18-5-26l158-81c17 23 44 38 75 38 51 0 93-42 93-94 0-51-42-93-93-93-52 0-94 42-94 93 0 9 2 17 4 24l-159 82c-17-22-43-36-73-36-51 0-93 41-93 93 0 52 42 93 93 93 31 0 58-15 75-37l157 80c-2 9-4 18-4 27 0 51 42 93 93 93 52 0 94-42 94-93 0-52-42-94-94-94z"/>
		</symbol>
	  
		<symbol id="icon-stats" viewBox="0 0 512 512">
		  <path d="m503 455l-29 0 0-389c0-15-13-28-28-28l-76 0c-16 0-29 13-29 28l0 389-19 0 0-256c0-16-12-28-28-28l-76 0c-16 0-28 12-28 28l0 256-19 0 0-123c0-16-13-29-29-29l-76 0c-15 0-28 13-28 29l0 123-29 0c-5 0-9 4-9 10 0 5 4 9 9 9l494 0c5 0 9-4 9-9 0-6-4-10-9-10z m-351 0l-95 0 0-123c0-5 4-10 9-10l76 0c5 0 10 5 10 10z m151 0l-94 0 0-256c0-5 4-9 9-9l76 0c5 0 9 4 9 9z m152 0l-95 0 0-389c0-5 5-9 10-9l76 0c5 0 9 4 9 9z"/>
		</symbol>
	  
		<symbol id="icon-telephone" viewBox="0 0 512 512">
		  <path d="m389 339c-16-17-37-17-54 0-13 12-25 25-38 38-3 3-6 4-10 2-8-5-17-9-25-13-37-24-68-53-95-87-13-16-25-34-34-54-2-4-1-7 2-10 13-12 25-25 38-38 17-17 17-38-1-55-9-10-19-20-29-30-11-10-21-21-31-31-17-16-38-16-54 0-13 13-25 26-38 38-12 12-18 26-20 42-2 26 5 52 14 76 19 50 47 95 82 136 47 56 103 100 168 132 29 14 60 25 93 27 23 1 42-5 58-22 11-13 23-24 35-35 17-18 17-38 0-55-20-21-40-41-61-61z m-20-85l39-7c-6-36-23-69-49-95-27-27-62-44-100-50l-6 40c30 4 57 17 78 38 20 21 33 46 38 74z m61-171c-45-45-102-74-166-83l-5 40c54 7 104 32 143 71 37 37 62 84 71 136l39-7c-10-60-39-114-82-157z"/>
		</symbol>
	  
		<symbol id="icon-arrow-bottom" viewBox="0 0 512 512">
		  <path d="m428 120l-172 168-171-168c-19-19-51-19-70 0-19 19-19 50 0 69l199 196c1 2 4 5 6 8 10 10 23 14 36 14 13 0 26-4 36-14 3-3 5-5 7-8l199-197c10-9 15-22 15-34 0-12-5-25-15-34-19-19-51-19-70 0z"/>
		</symbol>
	  
		<symbol id="icon-arrow-left" viewBox="0 0 512 512">
		  <path d="m393 427l-169-171 168-171c19-20 19-51 0-70-19-20-49-20-68 0l-196 198c-3 2-5 4-8 7-10 10-14 23-14 36 0 13 4 26 14 35 3 3 5 5 8 7l196 200c10 9 22 14 35 14 12 0 25-5 34-14 19-20 19-51 0-71z"/>
		</symbol>
	  
		<symbol id="icon-arrow-left-line" viewBox="0 0 512 512">
		  <path d="m466 216l-304 0 124-127c19-19 19-50 0-69-18-19-49-19-67 0l-192 196c-3 2-6 4-9 6-9 10-14 23-13 36-1 13 4 25 13 35 3 3 6 5 9 7l192 196c10 10 22 14 34 14 13 0 25-4 34-14 19-19 19-50 0-69l-124-127 303 0c23 0 42-19 42-42 0-23-19-42-42-42z"/>
		</symbol>
	  
		<symbol id="icon-arrow-left-line-bottom" viewBox="0 0 512 512">
		  <path d="m214 48l0 305-126-125c-20-19-51-19-70 0-19 19-19 49 0 68l196 192c2 3 4 6 7 8 9 10 22 14 35 14 13 0 26-4 35-14 3-2 5-5 7-8l196-193c10-9 15-21 15-34 0-12-5-24-15-34-19-18-50-18-69 0l-127 125 0-304c0-23-18-42-42-42-23 0-42 19-42 42z"/>
		</symbol>
	  
		<symbol id="icon-arrow-left-line-top" viewBox="0 0 512 512">
		  <path d="m298 468l0-304 127 124c19 19 50 19 69 0 20-19 20-49 0-68l-195-192c-2-3-4-5-7-8-10-9-22-14-35-14-13 0-26 5-36 14-2 3-4 6-6 8l-197 193c-9 10-14 22-14 34 0 12 5 25 14 34 19 19 50 19 69 0l127-124 0 303c0 23 19 42 42 42 24 0 42-19 42-42z"/>
		</symbol>
	  
		<symbol id="icon-arrow-right" viewBox="0 0 512 512">
		  <path d="m393 220c-2-3-5-5-8-7l-195-199c-19-19-50-19-69 0-19 20-19 51 0 71l168 170-169 172c-19 20-19 51 0 70 10 10 22 15 35 15 12 0 25-5 34-15l196-199c3-2 6-4 8-7 10-10 15-23 15-36 0-12-5-25-15-35z"/>
		</symbol>
	  
		<symbol id="icon-arrow-right-line" viewBox="0 0 512 512">
		  <path d="m494 222c-3-2-6-4-9-6l-192-196c-18-19-49-19-67 0-19 19-19 50 0 69l124 127-304 0c-23 0-42 19-42 42 0 23 19 42 42 42l303 0-124 127c-19 19-19 50 0 69 9 10 21 14 34 14 12 0 24-4 34-14l192-196c3-2 6-4 9-7 9-10 14-23 14-35 0-13-5-26-14-36z"/>
		</symbol>
	  
		<symbol id="icon-arrow-top" viewBox="0 0 512 512">
		  <path d="m86 393l171-169 171 168c20 19 51 19 70 0 20-19 20-50 0-69l-198-195c-2-3-4-6-7-9-10-9-23-14-36-14-13 0-26 5-36 14-2 3-4 6-6 9l-200 196c-9 9-14 22-14 34 0 13 5 25 14 35 20 19 51 19 71 0z"/>
		</symbol>
	  
		<symbol id="icon-behance-logo" viewBox="0 0 512 512">
		  <path d="m463 142l-129 0 0-32 129 0 0 32z m-214 131c8 12 12 28 12 46 0 19-4 36-14 51-6 10-14 18-23 25-10 8-22 13-35 16-14 3-29 4-45 4l-144 0 0-318 154 0c39 0 66 12 82 34 10 13 15 29 15 48 0 20-5 35-15 47-5 7-13 13-24 18 16 6 29 16 37 29z m-176-51l68 0c14 0 25-2 34-8 8-5 13-14 13-28 0-14-6-24-18-29-9-3-22-5-37-5l-60 0z m121 93c0-17-7-28-20-34-8-4-18-6-32-6l-69 0 0 85 68 0c14 0 24-2 32-6 14-6 21-20 21-39z m316-52c2 10 2 25 2 45l-166 0c1 23 9 39 24 48 9 6 20 9 33 9 13 0 24-4 33-11 4-3 8-9 12-15l61 0c-2 13-9 27-22 41-21 22-49 33-86 33-30 0-57-9-80-28-24-19-35-49-35-91 0-40 10-70 31-91 21-21 48-32 82-32 20 0 38 4 54 11 15 7 29 18 39 34 9 13 15 29 18 47z m-60 6c-1-16-6-28-16-36-9-9-21-13-35-13-16 0-27 5-36 13-8 9-14 21-16 36z"/>
		</symbol>
	  
		<symbol id="icon-black-male-user-symbol-2" viewBox="0 0 512 512">
		  <path d="m471 404l-2 3c-57 68-132 105-213 105-80 0-156-37-213-105l-2-3 1-2c11-72 48-129 105-162l4-3 3 4c27 28 63 44 102 44 39 0 75-16 102-44l3-4 4 3c57 33 95 90 106 162z m-215-148c71 0 128-58 128-128 0-71-57-128-128-128-70 0-128 57-128 128 0 70 58 128 128 128z"/>
		</symbol>
	  
		<symbol id="icon-check-mark-2" viewBox="0 0 512 512">
		  <path d="m230 427c-23 23-60 23-83 0l-130-130c-23-23-23-60 0-83 23-23 61-23 84 0l77 77c6 6 15 6 21 0l209-209c23-23 60-23 83 0 11 11 18 26 18 42 0 15-7 30-18 42z"/>
		</symbol>
	  
		<symbol id="icon-dribbble-logo" viewBox="0 0 512 512">
		  <path d="m256 0c-141 0-256 115-256 256 0 141 115 256 256 256 141 0 256-115 256-256 0-141-115-256-256-256z m157 133c25 31 41 71 43 114-29-6-57-9-82-9l0 0 0 0c-21 0-40 1-58 5-5-11-9-22-14-31 41-18 80-43 111-79z m-157-77c47 0 90 17 125 44-27 32-61 54-98 70-27-50-52-87-69-109 13-3 27-5 42-5z m-88 21c14 17 41 53 71 109-60 18-121 22-158 22-1 0-2 0-3 0l0 0c-6 0-11 0-16 0 15-58 54-105 106-131z m-112 179c0-1 0-2 0-3 6 0 13 1 22 1l0 0c40-1 111-4 182-26 3 8 7 17 11 26-47 16-85 41-112 66-27 25-45 49-55 65-30-35-48-80-48-129z m200 200c-44 0-85-15-119-40 7-11 23-33 47-57 25-23 59-48 104-62 15 42 29 91 39 146-22 8-46 13-71 13z m113-36c-10-49-23-94-37-134 13-2 27-3 41-3l1 0c24 0 50 3 78 10-10 52-40 98-83 127z"/>
		</symbol>
	  
		<symbol id="icon-ellipse" viewBox="0 0 512 512">
		  <path d="m256 0c-141 0-256 115-256 256 0 141 115 256 256 256 141 0 256-115 256-256 0-141-115-256-256-256z m0 481c-125 0-225-100-225-225 0-125 100-225 225-225 125 0 225 100 225 225 0 125-100 225-225 225z"/>
		</symbol>
	  
		<symbol id="icon-equal" viewBox="0 0 512 512">
		  <path d="m499 0l-486 0c-7 0-13 6-13 13 0 7 6 13 13 13l486 0c7 0 13-6 13-13 0-7-6-13-13-13z m-128 154l-358 0c-7 0-13 6-13 13 0 7 6 13 13 13l358 0c7 0 13-6 13-13 0-7-6-13-13-13z m128 0l-70 0c-7 0-13 6-13 13 0 7 6 13 13 13l70 0c7 0 13-6 13-13 0-7-6-13-13-13z"/>
		</symbol>
	  
		<symbol id="icon-error" viewBox="0 0 512 512">
		  <path d="m344 316l-60-60 60-60c8-8 8-20 0-28-8-8-21-8-28 0l-60 60-60-60c-8-8-20-8-28 0-8 8-8 21 0 28l60 60-60 60c-8 8-8 20 0 28 8 8 21 8 28 0l60-60 60 60c8 8 20 8 28 0 8-8 8-21 0-28z"/>
		</symbol>
	  
		<symbol id="icon-error-circle" viewBox="0 0 512 512">
		  <path d="m256 512c141 0 256-115 256-256 0-141-115-256-256-256-141 0-256 115-256 256 0 141 115 256 256 256z m0-465c115 0 209 94 209 209 0 115-94 209-209 209-115 0-209-94-209-209 0-115 94-209 209-209z m88 269l-60-60 60-60c8-8 8-20 0-28-8-8-21-8-28 0l-60 60-60-60c-8-8-20-8-28 0-8 8-8 21 0 28l60 60-60 60c-8 8-8 20 0 28 8 8 21 8 28 0l60-60 60 60c8 8 20 8 28 0 8-8 8-21 0-28z"/>
		</symbol>
	  
		<symbol id="icon-facebook" viewBox="0 0 512 512">
		  <path d="m512 85c0-45-40-85-85-85l-342 0c-45 0-85 40-85 85l0 342c0 45 40 85 85 85l171 0 0-193-63 0 0-86 63 0 0-33c0-57 43-109 96-109l69 0 0 85-69 0c-7 0-16 9-16 23l0 34 85 0 0 86-85 0 0 193 91 0c45 0 85-40 85-85z"/>
		</symbol>
	  
		<symbol id="icon-facebook-circular-logo" viewBox="0 0 512 512">
		  <path d="m256 1c-141 0-256 115-256 256 0 127 92 232 213 252l0-199-61 0 0-71 61 0 0-53c0-61 38-94 92-94 26 0 49 2 55 2l0 64-37 0c-30 0-36 15-36 35l0 46 71 0-9 71-62 0 0 201c127-15 225-123 225-254 0-141-115-256-256-256z"/>
		</symbol>
	  
		<symbol id="icon-funnel" viewBox="0 0 512 512">
		  <path d="m512 85c0-54-113-85-256-85-143 0-256 31-256 85 0 13 6 25 18 35l174 229 0 142c0 17 20 27 34 17l85-64c6-4 9-11 9-17l0-78 174-229c12-10 18-22 18-35z m-256-42c116 0 213 26 213 42 0 1 0 1 0 1-1 1-3 2-4 3-13 10-38 19-70 26-36 7-83 13-133 13 0 0-1 0-1 0-1 0-3 0-5 0-2 0-4 0-5 0 0 0-1 0-1 0-50 0-97-6-133-13-32-7-57-16-70-26-1-1-3-2-4-3 0 0 0 0 0-1 0-16 97-42 213-42z m21 373l-42 32 0-85 42 0z m11-96l-64 0-126-165c42 10 95 15 152 16 2 0 4 0 6 0 2 0 4 0 6 0 57-1 110-6 152-16z"/>
		</symbol>
	  
		<symbol id="icon-hash-key" viewBox="0 0 512 512">
		  <path d="m458 328l-61 0 19-146 42 0c46 0 46-71 0-71l-33 0 7-53c6-46-64-56-70-9l-8 62-146 0 6-53c6-46-64-56-70-9l-8 62-82 0c-46 0-46 71 0 71l73 0-19 146-54 0c-46 0-46 71 0 71l45 0-7 53c-6 46 64 56 70 9l8-62 146 0-6 53c-6 46 64 56 70 9l8-62 70 0c46 0 46-71 0-71z m-132 0l-147 0 20-146 146 0z"/>
		</symbol>
	  
		<symbol id="icon-heart-2" viewBox="0 0 512 512">
		  <path d="m374 31c-58 0-97 30-118 50-21-20-60-50-118-50-81 0-138 72-138 157 0 131 130 231 247 291 6 3 12 3 18 0 117-60 247-160 247-291 0-85-57-157-138-157z m-118 407c-98-51-216-140-216-250 0-61 38-117 98-117 47 0 85 28 101 52 4 6 10 10 17 10 7 0 13-4 17-10 0 0 34-52 101-52 60 0 98 56 98 117 0 110-118 199-216 250z"/>
		</symbol>
	  
		<symbol id="icon-heart-3" viewBox="0 0 512 512">
		  <path d="m374 31c-58 0-97 30-118 50-20-20-60-50-118-50-81 0-138 72-138 157 0 131 131 231 247 291 6 3 12 3 18 0 117-60 247-160 247-291 0-85-57-157-138-157z"/>
		</symbol>
	  
		<symbol id="icon-info" viewBox="0 0 512 512">
		  <path d="m335 92c0 37-30 67-67 67-38 0-68-30-68-67 0-37 30-68 68-68 37 0 67 31 67 68z m-67 405c-38 0-68-30-68-68l0-169c0-38 30-68 68-68 37 0 67 30 67 68l0 169c0 38-30 68-67 68z"/>
		</symbol>
	  
		<symbol id="icon-info-circle" viewBox="0 0 512 512">
		  <path d="m256 512c141 0 256-115 256-256 0-141-115-256-256-256-141 0-256 115-256 256 0 141 115 256 256 256z m0-465c115 0 209 94 209 209 0 115-94 209-209 209-115 0-209-94-209-209 0-115 94-209 209-209z m39 120c0 20-17 37-37 37-20 0-36-17-36-37 0-20 16-36 36-36 20 0 37 16 37 36z m-37 219c-20 0-36-16-36-36l0-92c0-20 16-37 36-37 20 0 37 17 37 37l0 92c0 20-17 36-37 36z"/>
		</symbol>
	  
		<symbol id="icon-instagram-logo" viewBox="0 0 512 512">
		  <path d="m373 0l-234 0c-77 0-139 62-139 139l0 234c0 77 62 139 139 139l234 0c77 0 139-62 139-139l0-234c0-77-62-139-139-139z m-119 394c-75 0-136-61-136-136 0-76 61-137 136-137 76 0 137 61 137 137 0 75-61 136-137 136z m138-239c-19 0-35-16-35-35 0-20 16-35 35-35 20 0 35 15 35 35 0 19-15 35-35 35z m-136 15c-48 0-86 38-86 86 0 48 38 86 86 86 48 0 86-38 86-86 0-48-38-86-86-86z"/>
		</symbol>
	  
		<symbol id="icon-line-arrow-left" viewBox="0 0 512 512">
		  <path d="m340 232l-259 0 100-101c9-10 9-25 0-34-9-9-25-9-34 0l-140 142c-9 9-9 25 0 34l140 142c5 5 11 7 17 7 6 0 12-2 17-7 9-10 9-25 0-34l-100-101 259 0c13 0 23-11 23-24 0-13-10-24-23-24z m148 0l-54 0c-13 0-24 11-24 24 0 13 11 24 24 24l54 0c13 0 24-11 24-24 0-13-11-24-24-24z"/>
		</symbol>
	  
		<symbol id="icon-line-arrow-right" viewBox="0 0 512 512">
		  <path d="m505 239l-140-142c-10-9-25-9-34 0-9 9-9 25 0 34l100 101-259 0c-13 0-23 11-23 24 0 13 10 24 23 24l259 0-100 101c-9 10-9 25 0 34 5 5 11 7 17 7 6 0 12-2 17-7l140-142c9-9 9-24 0-34z m-427-7l-54 0c-13 0-24 11-24 24 0 13 11 24 24 24l54 0c13 0 24-11 24-24 0-13-11-24-24-24z"/>
		</symbol>
	  
		<symbol id="icon-linkedin-letters" viewBox="0 0 512 512">
		  <path d="m6 170l110 0 0 330-110 0z m471 30c-23-25-54-37-92-37-14 0-26 1-38 5-11 3-21 8-29 14-8 6-14 12-19 17-4 6-8 11-13 18l0-47-109 0 0 16c0 11 0 44 0 99 0 55 0 127 0 215l109 0 0-184c0-11 2-20 4-27 5-11 12-21 21-28 10-8 21-12 35-12 19 0 33 7 42 20 9 13 14 31 14 55l0 176 109 0 0-189c0-49-11-86-34-111z m-415-189c-18 0-33 6-45 16-11 11-17 25-17 41 0 16 6 30 17 41 11 11 25 16 44 16l0 0c19 0 34-5 45-16 12-11 17-25 17-41 0-16-6-30-17-41-11-10-26-16-44-16z"/>
		</symbol>
	  
		<symbol id="icon-menu-2" viewBox="0 0 512 512">
		  <path d="m73 183c-40 0-73 32-73 73 0 41 33 73 73 73 41 0 74-32 74-73 0-41-33-73-74-73z m0 114c-22 0-40-18-40-41 0-23 18-41 40-41 23 0 41 18 41 41 0 23-18 41-41 41z m183-114c-41 0-73 32-73 73 0 41 32 73 73 73 41 0 73-32 73-73 0-41-32-73-73-73z m0 114c-23 0-41-18-41-41 0-23 18-41 41-41 23 0 41 18 41 41 0 23-18 41-41 41z m183-114c-41 0-74 32-74 73 0 41 33 73 74 73 40 0 73-32 73-73 0-41-33-73-73-73z m0 114c-23 0-41-18-41-41 0-23 18-41 41-41 22 0 40 18 40 41 0 23-18 41-40 41z"/>
		</symbol>
	  
		<symbol id="icon-min" viewBox="0 0 512 512">
		  <path d="m64 229c0-38 30-68 67-68l273 0c38 0 68 30 68 68 0 37-30 67-68 67l-273 0c-37 0-67-30-67-67z"/>
		</symbol>
	  
		<symbol id="icon-minus" viewBox="0 0 512 512">
		  <path d="m256 512c141 0 256-115 256-256 0-141-115-256-256-256-141 0-256 115-256 256 0 141 115 256 256 256z m0-465c115 0 209 94 209 209 0 115-94 209-209 209-115 0-209-94-209-209 0-115 94-209 209-209z m-93 211c0 12 10 23 23 23l140 0c13 0 23-11 23-23 0-13-10-24-23-24l-140 0c-13 0-23 11-23 24z"/>
		</symbol>
	  
		<symbol id="icon-next-2" viewBox="0 0 512 512">
		  <path d="m395 220c-3-3-5-5-8-7l-199-198c-19-20-51-20-70 0-19 19-19 50 0 70l171 171-172 171c-19 20-19 51 0 70 10 10 22 15 35 15 13 0 26-5 35-15l200-199c3-2 5-4 8-7 10-9 15-22 14-35 1-13-4-26-14-36z"/>
		</symbol>
	  
		<symbol id="icon-notification" viewBox="0 0 512 512">
		  <path d="m440 348l0-98c0-86-60-158-139-178 3-6 5-14 5-22 0-28-22-50-50-50-28 0-50 22-50 50 0 8 2 16 5 22-79 20-139 92-139 178l0 98c-19 7-33 25-33 47 0 28 22 50 50 50l85 0c8 38 42 67 82 67 40 0 74-29 82-67l85 0c28 0 50-22 50-50 0-22-14-40-33-47z m-184-315c9 0 17 8 17 17 0 9-8 17-17 17-9 0-17-8-17-17 0-9 8-17 17-17z m-83 217c0 10-8 17-17 17-9 0-17-7-17-17 0-64 53-116 117-116 9 0 17 7 17 16 0 9-8 17-17 17l0 0c-46 0-83 37-83 83z m83 229c-22 0-40-14-47-34l94 0c-7 20-25 34-47 34z"/>
		</symbol>
	  
		<symbol id="icon-padlock" viewBox="0 0 512 512">
		  <path d="m249 68c48-5 89 30 94 76 1 6 6 10 11 10l45 0c7 0 12-6 12-12-7-81-76-145-160-142-83 3-147 74-147 157l0 50-4 0c-22 0-41 18-41 41l0 223c0 23 19 41 41 41l312 0c22 0 41-18 41-41l0-223c0-23-19-41-41-41l-241 0 0-51c0-45 33-84 78-88z m-27 256c8-16 25-26 42-22 18 3 31 18 32 37 0 13-6 23-16 31-3 2-4 4-4 8 0 16 0 33 0 49 1 7-3 13-9 17-14 7-29-3-29-17l0 0c0-17 0-33 0-49 0-4 0-6-3-8-15-11-20-30-13-46z"/>
		</symbol>
	  
		<symbol id="icon-play-button-5" viewBox="0 0 512 512">
		  <path d="m478 128c-35-59-90-101-156-119-66-18-135-9-194 25-59 35-101 90-119 156-18 66-9 135 25 194 35 59 90 101 156 119 22 6 44 9 66 9 45 0 89-12 128-34 59-35 101-90 119-156 18-66 9-135-25-194z m-1 187c-15 59-53 109-106 140-53 30-115 38-174 22-59-15-109-53-140-106-30-53-38-115-22-174 15-59 53-109 106-140 36-20 75-30 115-30 20 0 40 2 59 8 59 15 109 53 140 106 30 53 38 115 22 174z m-98-83l-165-95c-8-5-19-5-28 0-8 5-14 14-14 24l0 190c0 10 6 19 14 24 5 3 10 4 14 4 5 0 10-1 14-4l165-95c9-5 14-14 14-24 0-10-5-19-14-24z m-14 25l-164 95c0 0-1 0-1 0-1 0-1-1-1-1l0-190c0 0 0-1 1-1 0 0 0 0 0 0 1 0 1 0 1 0l164 95c1 0 1 0 1 1 0 1 0 1-1 1z m48-123c-31-40-79-68-130-75-8-1-14 4-15 11-1 8 4 14 11 15 45 6 86 30 113 66 3 3 7 5 11 5 3 0 5-1 8-3 6-4 7-13 2-19z"/>
		</symbol>
	  
		<symbol id="icon-plus" viewBox="0 0 512 512">
		  <path d="m256 0c-7 0-13 6-13 13l0 70c0 7 6 13 13 13 7 0 13-6 13-13l0-70c0-7-6-13-13-13z m243 243l-486 0c-7 0-13 6-13 13 0 7 6 13 13 13l486 0c7 0 13-6 13-13 0-7-6-13-13-13z m-243-115c-7 0-13 6-13 13l0 358c0 7 6 13 13 13 7 0 13-6 13-13l0-358c0-7-6-13-13-13z"/>
		</symbol>
	  
		<symbol id="icon-plus-sign" viewBox="0 0 512 512">
		  <path d="m512 256c0 25-20 45-44 45l-167 0 0 167c0 24-20 44-45 44-12 0-23-5-32-13-8-8-13-19-13-31l0-167-166 0c-13 0-24-5-32-13-8-8-13-19-13-32 0-25 20-45 45-45l166 0 0-166c0-25 20-45 45-45 25 0 45 20 45 45l0 166 167 0c24 0 44 20 44 45z"/>
		</symbol>
	  
		<symbol id="icon-profile-1" viewBox="0 0 512 512">
		  <path d="m255 286c76 0 137-62 137-137 0-76-61-137-137-137-76 0-137 62-137 137 0 75 61 137 137 137z m0-238c56 0 101 45 101 101 0 55-45 101-101 101-55 0-101-46-101-101 0-56 46-101 101-101z m-237 452l476 0c10 0 18-8 18-18 0-95-77-172-172-172l-168 0c-95 0-172 77-172 172 0 10 8 18 18 18z m154-154l168 0c69 0 126 51 135 118l-438 0c9-66 66-118 135-118z"/>
		</symbol>
	  
		<symbol id="icon-quote-icon" viewBox="0 0 512 512">
		  <path d="m244 419c0 13-2 25-7 36-5 12-12 22-20 30-8 9-18 15-30 20-11 5-23 7-36 7-23 0-42-8-59-24-16-16-30-35-40-59-11-23-18-47-23-71-5-25-7-48-7-70 0-88 37-177 113-268 13-13 28-20 45-20 18 0 33 6 45 19 13 12 19 27 19 45 0 8-2 17-5 26-23 55-34 107-34 156 0 47 10 93 31 137 5 12 8 24 8 36z m246 0c0 13-2 25-7 36-5 12-12 22-20 30-8 9-18 15-30 20-11 5-23 7-36 7-22 0-42-8-59-24-16-16-30-35-40-59-11-23-18-47-23-71-5-25-7-48-7-70 0-88 37-177 113-268 13-13 28-20 45-20 18 0 33 6 45 19 13 12 19 27 19 45 0 8-2 17-5 26-23 55-34 107-34 156 0 47 10 93 31 137 5 12 8 24 8 36z"/>
		</symbol>
	  
		<symbol id="icon-quote-icon2" viewBox="0 0 512 512">
		  <path d="m22 93c0-13 2-25 7-36 5-12 12-22 20-30 8-9 18-15 30-20 11-4 23-7 36-7 22 0 42 8 59 24 16 16 30 36 40 59 11 23 18 47 23 72 5 24 7 47 7 69 0 88-37 178-113 268-13 13-28 20-45 20-18 0-33-6-45-19-13-12-19-27-19-45 0-8 2-17 5-26 22-55 34-107 34-156 0-47-10-93-31-137-5-12-8-24-8-36z m246 0c0-13 2-25 7-36 5-12 12-22 20-30 8-9 18-15 30-20 11-4 23-7 36-7 23 0 42 8 59 24 16 16 30 36 40 59 11 23 18 47 23 72 5 24 7 47 7 69 0 88-37 178-113 268-13 13-28 20-45 20-18 0-33-6-45-19-12-12-19-27-19-44 0-9 2-18 5-27 23-54 34-107 34-156 0-47-10-92-31-136-5-13-8-25-8-37z"/>
		</symbol>
	  
		<symbol id="icon-star-1" viewBox="0 0 512 512">
		  <path d="m501 233c10-10 14-24 9-38-4-13-16-23-29-25l-124-18c-6 0-10-4-13-8l-55-113c-6-12-19-20-33-20-14 0-27 8-33 20l-55 113c-3 4-7 8-13 8l-124 18c-13 2-25 12-29 25-5 14-1 28 9 38l90 87c4 4 5 10 4 15l-21 123c-2 11 1 22 8 30 11 13 30 17 46 9l110-58c5-3 11-3 16 0l110 58c6 3 12 4 18 4 10 0 21-5 28-13 7-8 10-19 8-30l-21-123c-1-5 0-11 4-15z"/>
		</symbol>
	  
		<symbol id="icon-tag" viewBox="0 0 512 512">
		  <path d="m399 27l-157 0c-10 0-19 4-26 11l-205 205c-15 14-15 38 0 53l157 157c15 15 39 15 53 0l205-204c7-7 11-17 11-27l0-157c0-21-17-38-38-38z m-65 132c-16 0-28-13-28-29 0-15 12-28 28-28 15 0 28 13 28 28 0 16-13 29-28 29z m140-94l0 175c0 8-3 17-9 23l-208 208 3 3c15 14 39 14 53 0l188-188c7-7 11-17 11-27l0-157c0-20-17-37-38-37z"/>
		</symbol>
	  
		<symbol id="icon-top-arrow" viewBox="0 0 512 512">
		  <path d="m454 383l-171-174c-3-2-5-4-7-6-9-9-20-14-31-14-11 0-22 5-31 14-3 2-5 4-5 6l-173 174c-9 9-14 20-14 31 0 11 5 22 14 31 17 18 44 18 60 0l149-149 149 149c18 18 45 18 60 0 18-20 18-47 0-62z m-354-261l290 0c17 0 33-15 33-33 0-18-16-33-33-33l-290 0c-18 0-33 15-33 33 0 18 15 33 33 33z"/>
		</symbol>
	  
		<symbol id="icon-twitter-black-shape" viewBox="0 0 512 512">
		  <path d="m512 97c-20 9-40 15-60 17 22-14 38-33 46-58-21 12-43 21-67 25-21-22-46-33-77-33-29 0-53 10-74 31-20 20-31 45-31 74 0 8 1 16 3 24-43-2-83-13-121-32-37-20-69-45-95-78-10 16-15 34-15 53 0 18 5 35 13 50 9 16 20 28 34 38-17-1-32-6-47-14l0 2c0 25 8 47 24 66 16 19 36 32 60 37-9 2-18 3-28 3-6 0-12 0-20-2 7 21 20 39 38 52 18 14 38 21 61 21-39 30-82 45-131 45-9 0-17 0-25-1 49 31 102 47 161 47 37 0 72-6 105-18 33-12 61-27 84-47 23-20 43-43 60-69 17-25 29-52 37-80 9-28 13-56 13-85 0-6 0-10-1-13 21-15 38-33 53-55z"/>
		</symbol>
	  
		<symbol id="icon-twitter-circular-logo-1" viewBox="0 0 512 512">
		  <path d="m256 0c-142 0-256 114-256 256 0 142 114 256 256 256 142 0 256-114 256-256 0-142-114-256-256-256z m134 211c0 3 0 4 0 7 0 80-60 172-172 172-34 0-66-11-92-27 5 0 10 1 16 1 28 0 54-9 75-25-27 0-48-18-56-42 3 0 8 1 12 1 6 0 11 0 17-1-27-6-48-30-48-59 7 4 18 7 27 7-17-10-27-28-27-49 0-11 3-21 7-30 30 36 74 60 124 63-2-5-2-9-2-14 0-33 27-60 60-60 17 0 33 8 44 20 14-3 27-8 38-15-5 13-14 25-27 33 12-2 24-5 34-9-7 7-18 18-30 27z"/>
		</symbol>
	  
		<symbol id="icon-war" viewBox="0 0 512 512">
		  <path d="m335 429c0 38-30 68-67 68-37 0-68-30-68-68 0-37 31-67 68-67 37 0 67 30 67 67z m-67-405c37 0 67 31 67 68l0 170c0 37-30 67-67 67-38 0-68-30-68-67l0-170c0-37 30-68 68-68z"/>
		</symbol>
	  
		<symbol id="icon-warning-circle" viewBox="0 0 512 512">
		  <path d="m256 512c141 0 256-115 256-256 0-141-115-256-256-256-141 0-256 115-256 256 0 141 115 256 256 256z m0-465c115 0 209 94 209 209 0 115-94 209-209 209-115 0-209-94-209-209 0-115 94-209 209-209z m39 303c0 20-17 36-37 36-20 0-36-16-36-36 0-20 16-37 36-37 20 0 37 17 37 37z m-37-219c20 0 37 16 37 36l0 92c0 20-17 37-37 37-20 0-36-17-36-37l0-92c0-20 16-36 36-36z"/>
		</symbol>
	
		<symbol id="icon-close" viewBox="0 0 512 512">
			<path d="m472 45c-6-5-16-5-22 0l-60 60c-5 6-5 15 0 22 6 5 16 5 22 0l60-60c6-6 6-15 0-22z m0 411l-411-411c-5-5-15-5-21 0-6 6-6 16 0 22l410 410c6 6 15 6 22 0 6-5 6-16 0-21z m-108-302c-6-6-15-6-22 0l-302 302c-5 5-5 15 0 21 6 6 16 6 22 0l302-302c6-6 6-16 0-21z"/>
		</symbol>
	
		<symbol id="icon-arrow-down" viewBox="0 0 512 512">
			<path d="m405 365l-140 140c-9 9-24 9-33 0l-140-140c-4-5-7-11-7-17 0-6 3-12 7-17 10-9 25-9 34 0l99 100 0-259c0-13 11-23 24-23 13 0 23 10 23 23l0 259 99-100c10-9 25-9 34 0 9 9 9 24 0 34z m-156-263c-13 0-24-11-24-24l0-54c0-13 11-24 24-24 13 0 23 11 23 24l0 54c0 13-10 24-23 24z"/>
		</symbol>
	
		<symbol id="icon-arrow-up" viewBox="0 0 512 512">
			<path d="m420 181c-10 9-25 9-34 0l-99-100 0 259c0 13-11 23-24 23-13 0-23-10-23-23l0-259-99 100c-10 9-25 9-34 0-9-9-9-24 0-34l140-140c9-9 24-9 33 0l140 140c4 5 7 11 7 17 0 6-3 12-7 17z m-157 229c13 0 24 11 24 24l0 54c0 13-11 24-24 24-13 0-23-11-23-24l0-54c0-13 10-24 23-24z"/>
		</symbol>
  
	</svg>

  
`;

svgWrap.innerHTML = svgData;
//document.body.appendChild(svgWrap);