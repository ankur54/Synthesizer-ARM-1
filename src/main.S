/*
The calculation for the steps to produce frequency of 440 hz is as explained below:
required frequency :=   440Hz
Number of full waves in 1 second := 440
Therefore, number of seconds required for a full wave :=  1/440
Therefore, number of seconds required for a half wave :=  1/880
Since this is a triangular wave its easy to think about havl of a full wave since its just a straight line
Number of samples any single half of the triangular wave contains :=   32767 + 32768 = 65535
So if 65535 samples are produced in half time period, 1 sample produced in 1 / (880 * 65535) = 1 / 57670800
But the BSP function produces 48000 waves in 1 second
So the step would be 57370800/48000 = 1201.475
*/


/*
The calculation for the steps to produce frequency of 440 hz is as explained below:
required frequency :=   440Hz
Number of full waves in 1 second := 440
Therefore, number of seconds required for a full wave :=  1/440
Therefore, number of seconds required for a half wave :=  1/880
Since this is a triangular wave its easy to think about havl of a full wave since its just a straight line
Number of samples any single half of the triangular wave contains :=   32767 + 32768 = 65535
So if 65535 samples are produced in half time period, 1 sample produced in 1 / (880 * 65535) = 1 / 57670800
But the BSP function produces 48000 waves in 1 second
So the step would be 57370800/48000 = 1201.475
*/


.syntax unified
.global main

.type main, %function
main:
  nop
  bl init                                 // Initialise the sound producing function
  mov r4, 0                               // r4 = 0

  loop:
    mov r5, 32767                         // r5 = 32767

    increment:
      mov r0, r4                          // r0 = r4
      bl BSP_AUDIO_OUT_Play_Sample        // play the sample whose amplitude value is the value stored in r4
      add r4, r4, 1201                    // Increment sample amplitude:  r4 = r4 + 1201
      cmp r4, r5                          // flag Z := r4 - r5
    bne increment                         // branch to label "Increment" if r4 != r5

    mov r5, 32768                         // r5 = 32768
    neg r5, r5                            // r5 = r5 * -1     We do this since we cannot directly put large negative value into register

    decrement:
      mov r0, r4                          // r0 = r4
      bl BSP_AUDIO_OUT_Play_Sample        // play the sample whose amplitude value is the value stored in r4
      sub r4, r4, 1201                    // decrement sample amplitude:  r4 = r4 - 1201
      cmp r4, r5                          // flag Z := r4 - r5
    bne decrement                         // branch to label "Decrement" if r4 != r5

  b loop                                  // keep on looping forever
.size main, .-main