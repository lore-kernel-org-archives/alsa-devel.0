From: Andrea Borgia <andrea@borgia.bo.it>
Subject: Re: [PATCH - SB-0500 1/1] preliminary support
 for	Toshiba SB-0500 (remote works)
Date: Mon, 05 Jan 2009 22:04:33 +0100
Message-ID: <496275E1.5020409@borgia.bo.it>
References: <s5hmye5pj7d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vsmtp1.tin.it (vsmtp1.tin.it [212.216.176.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 03ABE103832
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 22:04:34 +0100 (CET)
Received: from mononoke.chateaunet (79.2.57.216) by vsmtp1.tin.it (8.0.022)
	id 49467434012E3A5B for alsa-devel@alsa-project.org;
	Mon, 5 Jan 2009 22:04:33 +0100
Received: from localhost.chateaunet ([127.0.0.1])
	by mononoke with esmtp (Exim 4.69)
	(envelope-from <andrea@borgia.bo.it>) id 1LJwcj-0007vM-8j
	for alsa-devel@alsa-project.org; Mon, 05 Jan 2009 22:04:33 +0100
In-Reply-To: <s5hmye5pj7d.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Could you provide a bit description of the patch?
> Otherwise the changes look good and trivial enough.

The Toshiba SB-0500 is a rebranded version of the Creative Live24!
External: it shares the same chipset and only has minor "cosmetic"
differences.

I have tested the remote (which was my main goal) and basic audio output
seem to be ok. I am not at all certain that I got the mixer correctly
figured out, that's why I am badging it "preliminary".

A more concise version for logging:
"initial support for Toshiba SB-0500, a clone of Creative Live24!"

BR,
Andrea.
