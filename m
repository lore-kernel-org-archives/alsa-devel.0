From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Convert sgtl5000 to use
	devm_kzalloc()
Date: Wed, 28 Dec 2011 17:22:07 +0000
Message-ID: <20111228172207.GC26400@opensource.wolfsonmicro.com>
References: <1325078785-9063-1-git-send-email-festevam@gmail.com>
	<1325079011-9128-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 937CB10394D
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 18:22:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325079011-9128-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, axel.lin@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 28, 2011 at 11:30:11AM -0200, Fabio Estevam wrote:
> Convert sgtl5000 codec driver to use devm_kzalloc().

Applied, thanks.
