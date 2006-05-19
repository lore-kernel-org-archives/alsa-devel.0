From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: DMX6fire in the sound-card matrix
Date: Fri, 19 May 2006 18:13:45 +0100
Message-ID: <200605191813.45352.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I think it is overdue to update the soundcard matrix in respect of the 
Terratec DMX6fire.  How is this done?

In particular, it has for some time shown a specific warning about the front 
box not working.  Is it possible to counter that with a positive affirmation 
comment?

All the functions of the card and front box are fully supported from 1.0.11 
and there are no outstanding 'oddities' that affect performance as far as I 
can tell (& I am usually considered fussy).  Envy24control gives full access 
to the controls (which are more than you get with the Terratec Windows 
driver).  The functionality should list optical and coax digital in and out, 
plus midi in and out as well as internal wavetable connector, in addition to 
the analogue audio inputs and outputs.

The DMX6fire gives a pro-grade ice1712 sound system in a home-computer box.  I 
have recorded into audacity 8 Channels (plus 2 blank) at 24bit 96KHz with no 
glitches, and created CDs using the digital inputs to transfer live 
recordings to the PC.  Performance is now consistent and solid.  [..gets off 
soapbox..]

What do you think of having a rating system for supported soundcards so users 
(like me) can know what level of functioning to expect.  For example Bronze 
to indicate mainly working with some problems, through to Gold for complete, 
solid, well-affirmed performance?  The level of support for the STAudio 
DSP2000 for example seems to be a long way below that for the DMX6fire.

Regards  Alan



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
