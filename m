From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc: replace 0xffffffff with DMA_BIT_MASK
	macro
Date: Thu, 5 Jan 2012 05:36:27 +0000
Message-ID: <20120105053625.GA11867@opensource.wolfsonmicro.com>
References: <1325382183-21717-1-git-send-email-manabian@gmail.com>
	<20120102132933.GN4300@opensource.wolfsonmicro.com>
	<CAGhQ9VyxHvCFy4EJyabi8Tfy5NRQaOe4huAPXVYsrQ0GBDsc9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A0E281038CB
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 06:36:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAGhQ9VyxHvCFy4EJyabi8Tfy5NRQaOe4huAPXVYsrQ0GBDsc9g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Joachim Eastwood <joachim.eastwood@jotron.com>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 04, 2012 at 07:04:29PM +0100, Joachim Eastwood wrote:
> On Mon, Jan 2, 2012 at 2:29 PM, Mark Brown

> > Please also use subject lines corresponding to the subsystem.

> The subject of this mail includes "asoc". Is there anything I should
> do different?

If you look at all the other commits in the subsystem you'll see they're
for "ASoC".
