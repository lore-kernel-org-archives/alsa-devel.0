From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound: at91sam9g20ek_2mmc board uses same
 audio connexion as at91sam9g20ek
Date: Fri, 9 Oct 2009 12:07:47 +0100
Message-ID: <20091009110747.GA7104@sirena.org.uk>
References: <1255018789-3437-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EA42B103AC1
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 13:07:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1255018789-3437-1-git-send-email-nicolas.ferre@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: sedji.gaouaou@atmel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 08, 2009 at 06:19:49PM +0200, Nicolas Ferre wrote:
> The modified revision of at91sam9g20 Evaluation Kit rev. C and onwards share
> with previous ones its audio connexion to Wolfson wm8731. Modify the SoC file
> to extend the machine ID checking.

> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied, thanks.
