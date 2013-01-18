From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: wm_adsp: Set ADSP1 clock rate to
 match sys clock
Date: Fri, 18 Jan 2013 17:46:34 +0900
Message-ID: <20130118084632.GG4960@opensource.wolfsonmicro.com>
References: <1358498590-7365-1-git-send-email-crattray@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C8727265DE7
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 09:46:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1358498590-7365-1-git-send-email-crattray@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chris Rattray <crattray@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 18, 2013 at 08:43:09AM +0000, Chris Rattray wrote:
> Sets the ADSP1 clock rate to match the system clock
> rate. To support this the codec driver provides
> details of register containing the system clock
> control bits.

Applied, thanks.
