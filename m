From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DMIC codec - Add input widget
Date: Thu, 12 May 2011 17:40:47 +0200
Message-ID: <20110512154047.GA17626@opensource.wolfsonmicro.com>
References: <1305213980-4700-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EF6BB243EF
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 17:40:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1305213980-4700-1-git-send-email-lrg@ti.com>
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
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 12, 2011 at 04:26:20PM +0100, Liam Girdwood wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
> 
> Digital microphones can have some additional elements in their
> audio path (like microphone bias). An input widget is required
> for digital microphone CODEC driver to allow external connections
> in machine drivers.
> 
> Change-Id: Ice9fcb2dbe9acccd859f90ae875d2280926bf08a

Applied, with the Change-Id stripped out.
