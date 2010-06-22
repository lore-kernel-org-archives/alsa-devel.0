From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: RX-51: Add basic jack detection
Date: Tue, 22 Jun 2010 11:16:02 +0100
Message-ID: <20100622101602.GB15255@opensource.wolfsonmicro.com>
References: <1277118900-30100-1-git-send-email-jhnikula@gmail.com>
	<1277118900-30100-2-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D58601038C3
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jun 2010 12:16:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1277118900-30100-2-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 21, 2010 at 02:15:00PM +0300, Jarkko Nikula wrote:
> This patch adds GPIO jack detection to Nokia N900/RX-51. At the moment only
> SND_JACK_VIDEOOUT type is reported. More types could be reported after
> getting more audio features supported and necessary drivers integrated for
> implementing automated accessory detection.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
