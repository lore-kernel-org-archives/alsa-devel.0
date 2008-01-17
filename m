From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [ALSA] mpc8610: Add mmap support
Date: Thu, 17 Jan 2008 15:41:40 -0600
Message-ID: <478FCB94.9020506@freescale.com>
References: <12005823754197-git-send-email-timur@freescale.com>
	<478F8129.5030408@gmail.com> <478F82E9.1050809@freescale.com>
	<Pine.LNX.4.58.0801171316070.16628@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id D4E0C246BC
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 22:42:10 +0100 (CET)
In-Reply-To: <Pine.LNX.4.58.0801171316070.16628@shell2.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: alsa-devel@alsa-project.org, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Trent Piepho wrote:

> The key thing to know is that you will not get an error message if your
> page callback is wrong!  Everything will appear to work.  You just won't
> hear any sound.

When I said playback works fine, I was wearing my headphones. :-)

-- 
Timur Tabi
Linux kernel developer at Freescale
