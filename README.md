<h1 align="center">MARTEST <br> Hacia una evaluación hecha a medida</h1>

<div align="center">
  <strong>Manual para elaborar un Test Adaptativo Informatizado Multidimensional (MTAI) en R</strong>
</div>

<div align="center">
  <sub>Hecho con ❤︎ por
  <a href="https://www.linkedin.com/in/carlos-p%C3%A9rez-baa6b81a3/">Carlos Pérez</a>
    </a>
</div>

<br>

MARTEST es parte de un proyecto de Final de Grado que puede encontrarse en <a href="https://ddd.uab.cat/collection/tfg">Dipòsit digital de documents de la UAB</a>, basado en elaborar un MTAI en R acompañado de un manual para su uso.

## Contenido

Este proyecto ha sido redactado con el objetivo de facilitar la comprensión de los conceptos
que se van exponiendo a lo largo de los capítulos para personas con algunas nociones de
psicometría, estadística y programación o que estén interesadas en los TAIs, en especial a
aquellos basados en Teoría de Respuesta al Ítem Multidimensional (MIRT) con finalidades
académicas.

El manual apoya y explica qué es necesario saber para aplicar el TAI, unificando el código
en R que lo implementa con la teoría que se expone. Este código se puede encontrar en los
apéndices, donde también se encuentra un pequeño tutorial en R para aquellas personas
que no estén familiarizadas con él. Además, se asume que aquella persona que quiera
aplicar este proyecto parta de respuestas a ítems ya administrados, y que estos sean de
respuesta binaria.

El manual está adaptado a ítems dicotómicos y se proporcionan ejemplos del código aplicado a una simulación de respuestas de 8000 personas a 60 ítems. El primer capítulo hace una introducción a los valores en blanco, contextualiza su
problemática en un contexto académico y se propone una imputación con el algoritmo
Esperanza-Maximización (EM). Es verdad que la imputación múltiple (MI), ante valores
en blanco, consigue mejores resultados que una imputación única, pero aquí no se asume
que la persona tenga una gran potencia computacional y las aplicación de la MI para
calibrar un banco de ítems no es algo común.

El segundo capítulo consta de una introducción a la Teoría de Respuesta al Ítem (TRI) y a
la MIRT donde se explica qué modelos y qué propiedades tienen sus parámetros para
modelar las características de un ítem y su interacción con una persona.

El tercer capítulo trata cómo se obtienen los parámetros explicados en el capítulo anterior.
Aquí se explican los más comunes para ítems dicotómicos multidimensionales, pero no
se mencionan modelos no paramétricos, nominales o modelos logísticos anidados, entre
otros. Además, la mitad de este capítulo se basa en pruebas de bondad de ajuste para
evaluar el modelo que se obtenga.

Finalmente, el último capítulo implementa un MTAI, dando sentido a todos los capítulos
anteriores.

## Uso

Este manual no pretende ser una solución a todas aquellas instituciones que quieran
aplicar un MTAI. Su finalidad es académica aunque tenga
un gran componente práctico. Se recomienda que aquellas personas interesadas en
implementar este tipo de avances busquen asesoramiento experto.

## Licencia 

Este manual es de dominio público. En la medida en que la ley lo permita, renuncio
a todos los derechos de autor y derechos conexos o afines a esta obra.
Para ver una copia de la licencia visite:
https://creativecommons.org/licenses/by/4.0/

