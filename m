From: Jozef Kosoru <zyzstar@uid0.sk>
Subject: aserver, smix
Date: Wed, 26 Feb 2003 18:02:19 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030226180219.B32649@osiris.uid0.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from osiris.uid0.sk (osiris.uid0.sk [62.168.97.100])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA06543
	for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2003 17:59:45 +0100
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

A couple of questions:

I would like to ask what is the main purpose of the aserver. It can run
on the same machine as the client only (AFAIK) and it cannot mix multiple
client streams into the one device. So I've missed the point of that
application -- is there something for which it could be good for?

ALSA plugin documentation mentions the 'smix' plugin. But I cannot find
any further information nor the source code in the library for that. Is
it something which will be introduced it the future ALSA releases?
According the doc it is exactly something I've been looking for a long
time; pcm device sharing.

--
jozef kosoru [zyzstar] <zyzstar@uid0.sk>



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
