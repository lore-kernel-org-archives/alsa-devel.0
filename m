From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: 1.0.6rc1 packages
Date: Wed, 04 Aug 2004 23:17:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41116082.20500@superbug.demon.co.uk>
References: <Pine.LNX.4.58.0408042050320.15189@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net [194.217.242.92])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 75903271
	for <alsa-devel@alsa-project.org>; Thu,  5 Aug 2004 00:17:39 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.58.0408042050320.15189@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> Hi all,
> 
> 	the 1.0.6rc1 ALSA packages are available for testing.
> 
> 						Jaroslav
> 

compiles completely with "./configure --with-cards=all".
also compiles with "./configure --with-cards=emu10k1,audigyls"
"make install" with emu10k1 and audigyls works fine.

kernel version 2.6.8rc2.

Cheers
James




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
