From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] ASoC: Fix compilation error with
	davinci-sffsdr module
Date: Thu, 15 Jan 2009 14:37:54 -0800
Message-ID: <200901151437.55027.david-b@pacbell.net>
References: <1231277025-2100-1-git-send-email-hugo@hugovil.com>
	<496FB439.1090900@boundarydevices.com>
	<20090115172818.8a216670.hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com (smtp117.sbc.mail.sp1.yahoo.com
	[69.147.64.90]) by alsa0.perex.cz (Postfix) with SMTP id 320C71038C5
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 23:37:57 +0100 (CET)
In-Reply-To: <20090115172818.8a216670.hugo@hugovil.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Hugo Villeneuve <hugo@hugovil.com>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 15 January 2009, Hugo Villeneuve wrote:
> Did someone test the latest git tree and audio on a DM644x EVM to see if
> it still works?

In the last week or two, yes.  To validate that EDMA cleanup,
and incidentally fixing the playback speed.

- Dave
