From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] blackfin I2S(TDM mode) CPU DAI driver
Date: Tue, 28 Jul 2009 22:14:59 +0100
Message-ID: <20090728211458.GA4505@sirena.org.uk>
References: <1248689199-3730-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9545424794
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jul 2009 23:15:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1248689199-3730-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 27, 2009 at 06:06:39PM +0800, Barry Song wrote:
> The I2S DAI driver for blackfin SPORT, but works in TDM mode.
> I2S is not a special case of TDM with only left and right two slots for
> SPORT interface. I2S coordinates with TDM in SPORT, but not a part of

Applied, thanks.
