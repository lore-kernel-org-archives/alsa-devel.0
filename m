From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc-of.h file
Date: Tue, 8 Jul 2008 13:42:20 +0100
Message-ID: <20080708124219.GC14539@sirena.org.uk>
References: <1215520197.18736.11.camel@dinesh.dua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D3B67243DA
	for <Alsa-devel@alsa-project.org>;
	Tue,  8 Jul 2008 14:42:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1215520197.18736.11.camel@dinesh.dua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dinesh <dinesh.dua@coraltele.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 08, 2008 at 05:59:57PM +0530, dinesh wrote:
> I need to use function of_snd_soc_register_platform of soc-of.o i got
> soc-of.c file from patch [PATCH 1/3] ALSA SoC: Add OpenFirmware helper
> for matching bus and codec drivers with  but i am not able to find
> soc-of.h file please provide this to me. 

If Grant isn't able to post an update with the .h included soon enough
you should be able to construct a header file yourself using the
definition of the function to provide the prototype.
