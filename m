From: federico <xaero@inwind.it>
Subject: Re: [Jackit-devel] the big jack bug... > crappy audio on XRUNS
Date: Sun, 06 Nov 2005 18:26:04 +0100
Message-ID: <436E3CAC.2000200@inwind.it>
References: <436E25DB.2070804@inwind.it> <7qek5tadsr.fsf@io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <7qek5tadsr.fsf@io.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jack O'Quin <joq@io.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jack O'Quin ha scritto:

>federico <xaero@inwind.it> writes:
>
>  
>
>>it happens randomly, while I play a soft synth, that jack XRUNs once,
>>and the audio become crappy, noisy, like a kinda of digital
>>effect....bit crusher?
>>
>>then all synthesizers (all audio apps) sound the same sh*t...
>>i tried recording with ardour the output, and the output is clean, so
>>I guess is a problem of sync or something that has to do with the
>>hardware (soundcard).
>>    
>>
>
>This is likely a hardware problem.
>
>Have you reported it on alsa-devel?  What card do you have?
>  
>
it is an Echoaudio Gina24
the problem seems to came up more frequently with lower period sizes


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
