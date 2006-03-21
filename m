From: John Shillinglaw <jshillinglaw@hotpop.com>
Subject: Digitech GNX-4 Guitar Workstation ( w/ usb audio/midi ports)
Date: Tue, 21 Mar 2006 17:33:27 -0500
Message-ID: <1142980408.13175.15.camel@Pippin.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-out.hotpop.com (smtp-out.hotpop.com [38.113.3.71])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E26471A8
	for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2006 23:33:35 +0100 (MET)
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.105])
	by smtp-out.hotpop.com (Postfix) with SMTP id 887A11F915B3
	for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2006 22:33:23 +0000 (UTC)
Received: from Pippin.home (cpe-065-188-052-217.sc.res.rr.com [65.188.52.217])
	by smtp-3.hotpop.com (Postfix) with ESMTP id 51C531F803EC
	for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2006 22:33:23 +0000 (UTC)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I just purchased a Digitech gnx-4 guitar workstation. It has an usb port
which provides 4 channels of audio to the pc, 2 back down, midi in/out,
and a cf readable from the pc. It's man id is 0x1210,and product id
0004.

I've been testing it under linux, and it seems to work, but doesn't seem
to be explicitly listed in the usb drivers. The cf card will show up
under linux, and the midi ports show up under aplaymidi -l. The audio
seems to be present, but doesn't show up under the mixer.


Any help in adding this device will be appreciated, I am available for
whatever testing or  work is needed.

John




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
