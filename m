From: JoDaY <jo.day@laposte.net>
Subject: Re: Tascam US-122: tascam_firmware-0.1 and alsa-firmware
Date: Sat, 29 Nov 2003 18:10:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FC8D323.4060206@laposte.net>
References: <3FC60BAA.4060809@laposte.net> <200311271556.36745.annabellesgarden@yahoo.de> <20031127192437.GA561@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031127192437.GA561@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for your quicker reponses Takashi Iwai, Karsten Wiese, Marten 
Langer !

Martin Langer wrote:
> On Thu, Nov 27, 2003 at 03:56:36PM +0100, Karsten Wiese wrote:
> 
>>Am Donnerstag, 27. November 2003 15:35 schrieb JoDaY:
>>
>>>But I can't see it in any mixer: alsamixer return No mixer elems found.
>>
>>there is no mixer support yet. but it is certainly implementable ;-)
>>
> 
> 
> The mixer is implemented in the hardware: some knobs for changing input or 
> output level and a switch for changing the input source! It's absolutely
> mixerless on the sw side and the windows driver is also mixerless (IIRC).
> 
> Finally: Play/Record/MIDI will work without such software mixer!
> 
> martin
> 

It's ok :) I'm sorry for my bad question ... I should have ask you where 
can I reach the US-122, my problem in fact is that I can't find this 
card in /dev in order to point a sound or midi player to it so that the 
US-122 make noise (sound :) ).

I've also noticed that the Midi in LED is lighting, the US-122 's owner 
doesn't seem to have this when he uses it on windows.

I use the cvs version from 2003/11/27.

I'm working on Knoppix, my aim is to make one with US-122 support, 
US-122 is now lighting on live-cd when hotplug is starting :)

Ps: I hope my english is understanding ;)

Bien le bonjour de Normandie !

JoDaY



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
