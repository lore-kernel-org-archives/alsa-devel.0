From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 03/11] wss_lib: rename cs4321_foo to wss_foo
Date: Tue, 05 Aug 2008 08:22:49 +0200
Message-ID: <4897F1B9.2090305@keyaccess.nl>
References: <20080805061817.9D87F1465021@f15.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D2B924524
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 08:22:54 +0200 (CEST)
In-Reply-To: <20080805061817.9D87F1465021@f15.poczta.interia.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: krzysztof.h1@poczta.fm
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05-08-08 08:18, krzysztof.h1@poczta.fm wrote:

> I think about doing some code improvements in the opl3sa2 e.g. use
> WSS tlv macros instead of the tlv macros defined localy.

The more unification the better. Will review and test. opl3sa2 is 
painfree hardware to test.

Rene.
