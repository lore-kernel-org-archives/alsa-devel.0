From: "Mihai T. Lazarescu" <mihai@email.it>
Subject: Help fix driver for YMF-744B on Toshiba Tecra 8100?
Date: Wed, 18 Feb 2004 11:47:02 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402181132500.19312@laptop.localdomain>
Reply-To: "Mihai T. Lazarescu" <mihai@email.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello developers,

I would like to try to fix the long standing bug of the ALSA
driver for the Toshiba Tecra 8100 YMF-744B card.

My experiences until now led, in the best of the cases,
to sound with cracks and distortions, no matter the mixer
settings (mostly if at boot time the OSS drivers are loaded,
then rmmod them and insmod ALSA).  In the worst, only high
pitch whistles with some cracks here and there (mostly if ALSA
is loaded directly at boot).

I am quite familiar with C, but not with ALSA internals.
I'd like to try and debug this if someone is willing to direct
me to what to look for.

Thanks in advance!

Mihai


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
