From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Improve card registration
	error messaging	for large DAI links.
Date: Mon, 9 Jan 2012 22:23:42 +0000
Message-ID: <20120109222341.GF30766@opensource.wolfsonmicro.com>
References: <1326110969-6173-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 704EE243A9
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 23:23:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326110969-6173-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 09, 2012 at 12:09:29PM +0000, Liam Girdwood wrote:
> Print out the offending DAI link entry when a naming error occurs. Makes
> thing easier to debug for machines with a large number of DAI links.

Applied, thanks.
