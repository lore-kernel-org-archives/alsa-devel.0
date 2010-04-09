From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] WM8750: Convert to new API
Date: Fri, 9 Apr 2010 13:00:53 +0100
Message-ID: <20100409120053.GA19133@opensource.wolfsonmicro.com>
References: <1270752531-6016-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82022103822
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Apr 2010 14:00:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1270752531-6016-1-git-send-email-marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: ben@simtec.co.uk, alsa-devel@alsa-project.org, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 08, 2010 at 08:48:51PM +0200, Marek Vasut wrote:
> Register the WM8750 as a SPI or I2C device. This patch mostly shuffles code
> around. Hugely inspired by WM8753 which was already converted.
> 
> Also, this patch fixes the Jive and Spitz machine.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Applied, thanks.
