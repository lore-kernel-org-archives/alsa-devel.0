From: jfm3 <jfm3@ouroboros-complex.org>
Subject: USB serial parallel MIDI
Date: 20 Feb 2003 14:59:00 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045771141.1108.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

What is the difference between serialmidi and serial-u16550?

Is it possible to use a serial midi interface from a USB->serial device
with serialmidi?

Is it possible to use the MTPAV through a PCMCIA parallel port?

I have a MIDI interface that I can attach to my Palm Pilot. It relies on
the palm pilot to set the baud rate to that of MIDI, and then just
converts the electronic signals to be appropriate for midi and provides
MIDI shaped jacks. Is there an ALSA driver that can send MIDI through
this sort of device? Can I do USB->PCserial->MIDI this way?

I know, I know. It's a silly long shot, but I figured I'd ask.

-- 
(jfm3  2838 BCBA 93BA 3058 ED95  A42C 37DB 66D1 B43C 9FD0)



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
