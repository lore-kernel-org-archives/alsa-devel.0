From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 04/11] wss_lib: use struct snd_wss instead
	of snd_ad1848
Date: Tue, 05 Aug 2008 05:41:10 +0200
Message-ID: <4897CBD6.8020603@keyaccess.nl>
References: <20080731210437.4d40b898.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id BB0A524546
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 05:41:14 +0200 (CEST)
In-Reply-To: <20080731210437.4d40b898.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 31-07-08 21:04, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> The snd_wss is superset of the snd_ad1848 so kill
> the latter and replace it with the snd_wss.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> 
> Only small formatting changes in the header comments.

Acked-by: Rene Herman <rene.herman@gmail.com>

Rene.
