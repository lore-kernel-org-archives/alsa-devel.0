From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: MAX9877: add MAX9877 amp driver
Date: Wed, 15 Jul 2009 17:01:39 +0100
Message-ID: <20090715160139.GA20079@rakim.wolfsonmicro.main>
References: <4A5DBEA8.3060201@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E9FAC2460E
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jul 2009 18:01:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A5DBEA8.3060201@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 15, 2009 at 08:34:00PM +0900, Joonyoung Shim wrote:
> The MAX9877 combines a high-efficiency Class D audio power amplifier
> with a stereo Class AB capacitor-less DirectDrive headphone amplifier.

Applied all three, thanks!

I did a small edit to the driver patch to sort the entry in
SND_SOC_ALL_CODECS.
