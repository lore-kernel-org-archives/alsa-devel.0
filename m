From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] wm9713 and virtual Line mixer
Date: Mon, 21 Jan 2008 10:36:02 +0000
Message-ID: <20080121103602.GA31527@rakim.wolfsonmicro.main>
References: <87lk6kdq7h.fsf@polgara.paysbobval>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 742D424415
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 11:36:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87lk6kdq7h.fsf@polgara.paysbobval>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <rjarzmik@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 21, 2008 at 12:36:50AM +0100, Robert Jarzmik wrote:

> Missing this mixer causes Mono Mixer and Speaker Mixer lack of support
> for input from Line Left and Line Right signals.

Thanks - applied to the ASoC git tree.
