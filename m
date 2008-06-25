From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [asoc-dev][RFC/PATCH 0/2] Generic DAPM
	register	modifier widget
Date: Wed, 25 Jun 2008 16:40:33 +0100
Message-ID: <1214408433.3877.103.camel@localhost.localdomain>
References: <1214394128-7062-1-git-send-email-jarkko.nikula@nokia.com>
	<1214395280.3877.61.camel@localhost.localdomain>
	<20080625151555.81154289.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0FD0C243B5
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 17:40:51 +0200 (CEST)
In-Reply-To: <20080625151555.81154289.jarkko.nikula@nokia.com>
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

On Wed, 2008-06-25 at 15:15 +0300, Jarkko Nikula wrote:
> On Wed, 25 Jun 2008 13:01:20 +0100
> "ext Liam Girdwood" <lg@opensource.wolfsonmicro.com> wrote:
> 
> > > So I came with this idea of generic register modifiers widget and
> > > event handler for it.
> > > 
> > 
> > Any chance you could also add a little text to
> > Docs/sound/alsa/soc/dapm.txt for this.
> > 
> Documentation? That's difficult and actually forgot it completely :-)
> 
> But is it documented already? "There are convience macros defined in
> soc-dapm.h that can be used to quickly build a list of widgets of the
> codecs and machines DAPM widgets."
> 

Sorry, just to clarify, I was meaning 1 line in section 2 of dapm.txt
(the widget type table). Just a little description next to the others.

Thanks

Liam
