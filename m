From: Giorgio Padrin <giorgio@mandarinlogiq.org>
Subject: PXA2xx i2Sound: support for PXA2xx I2S audio
Date: Fri, 4 Nov 2005 11:52:22 +0100
Message-ID: <200511041152.22570.giorgio@mandarinlogiq.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
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
To: alsa-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Hi all,

I want to contribute code to support PXA2xx I2S audio, native kernel 2.6/ALSA. 
Now rather ready for a public release.
Download from: "http://www.mandarinlogiq.org/PXA2xx i2Sound/"

It includes audio engine and overall card management.

See h2200_audio (also on the site) for a sample glue module, that support the 
audio of an iPAQ h2200 handheld, using it together with a module for the 
UDA1380 codec.
You may find support modules for a few other handhelds in the handhelds.org 
cvs.

I wish to know whether there are other similar works in development.

Giorgio 




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
