From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [topic/asoc][PATCH 0/2] minor clean-ups and aic3x
	naming change
Date: Tue, 7 Oct 2008 13:00:42 +0100
Message-ID: <20081007120041.GE19835@sirena.org.uk>
References: <1223380163-29041-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 23AA324546
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 14:00:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1223380163-29041-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 07, 2008 at 02:49:21PM +0300, Jarkko Nikula wrote:
> These two patches are generated agains Takashi's topic/asoc branch.
> 
> First one will remove unused AUDIO_NAME define from codec drivers. IMO
> it didn't look so readable to use this define so I end up removing it.
> 
> Second one will use uniform naming like other tlv320aic drivers for
> tlv320aic3x.

Thanks - both are

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Takashi, I have a small patch queue building up for you - I'll add these
to that.
