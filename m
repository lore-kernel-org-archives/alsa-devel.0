From: Jim Carroll <jim@maplesong.com>
Subject: getting started: USBpre support
Date: Sun, 30 Oct 2005 17:00:47 +0000 (UTC)
Message-ID: <loom.20051030T175159-949@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi,

I'm having trouble getting started writing an alsa driver for my Sound Devices
USBpre microphone interface.  It is a full sound card, playing and recording
full duplex, but it also drives my condenser microphones with phantom power.  

I've been reading the linux kernel driver book, and Takashi Iwai's
writing-an-alsa-driver.pdf, but neither are quite applicable to my hardware. 

What else can I read to get started?  

I've been looking at the generic usb alsa driver, and starting to modify it for
my usb device... does anyone have a similar stand-alone kernel module project
that I could use as a starting place?

I'm on Ubuntu Breezy 2.6.12 and have some windows source for reference on how to
talk to the USBpre.

Thanks,
-Jim Carroll



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
