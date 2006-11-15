From: Richi Plana <richip@richip.dhs.org>
Subject: Frequency Problems with 0d8c:0201 and snd-usb-audio
Date: Wed, 15 Nov 2006 11:00:13 -0700
Message-ID: <1163613613.3406.14.camel@richip.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have an ASRock 939Dual-VSTA mobo that comes with a C-Media Electronics
based sound system. Its USB Vendor and Product ID is 0d8c:0201, I'm
using Fedora Core 6 with ALSA drivers and libs version 1.0.13 and am
experiencing some problems with it.

The one major problem I have is that any audio played at 48000 Hz sounds
distorted. Playing the same audio at 44100 Hz is fine. I'm using this
computer as a MythTV machine with a WinTV PVR-350 video capture card
that seems to want to sample at 48000 Hz.

The second problem is with the mixer. I just can't get audio to come out
of the side, rear and center speakers. I'll have to play around with
this more, but it's not as bad as the first problem.

Thanks for any help/advice. I've a technical background so I
troubleshoot given good leads.
--

Richi


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
