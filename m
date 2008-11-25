From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ALSA: SoC: Add support for TI SDP3430
Date: Tue, 25 Nov 2008 15:15:12 +0000
Message-ID: <20081125151510.GG12414@sirena.org.uk>
References: <1227586883-31937-1-git-send-email-mesak82@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E37A724475
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:15:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227586883-31937-1-git-send-email-mesak82@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Misael Lopez Cruz <mesak82@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 24, 2008 at 10:21:23PM -0600, Misael Lopez Cruz wrote:
> This patch add ASoC support for TI SDP3430. It's based on Gumstix
> Overo SoC code by Steve Sakoman.

> Signed-off-by: Misael Lopez Cruz <mesak82@gmail.com>

Applied, but it would be really good to see a shared driver for all the
various OMAP+TWL4030 combinations.
