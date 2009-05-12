From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RESEND][PATCH 1/4] pxa2xx-i2s:
	Proper	initialization
Date: Tue, 12 May 2009 15:52:29 +0100
Message-ID: <20090512145228.GJ29889@sirena.org.uk>
References: <4A089D75.3070406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 619E524724
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 16:52:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A089D75.3070406@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karl Beldan <karl.beldan@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel email list <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, May 11, 2009 at 11:49:41PM +0200, Karl Beldan wrote:
> Reset FIFO logic and registers, and make sure REC and RPL functions along
> with FIFO service are disabled at probe.
> 
> Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>

Applied, thanks.
