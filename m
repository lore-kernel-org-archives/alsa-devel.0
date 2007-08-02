From: =?iso-8859-2?q?Rafa=B3_Zawadzki?= <bluszcz@jabberpl.org>
Subject: Re: problem with ATI SB600 Azalia
Date: Thu, 2 Aug 2007 14:21:25 +0200
Message-ID: <200708021421.25389.bluszcz@jabberpl.org>
References: <200708012157.11350.bluszcz@jabberpl.org>
	<s5hzm1as3fm.wl%tiwai@suse.de>
	<200708021420.26082.bluszcz@jabberpl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jabberpl.org (unknown [195.116.239.3])
	by alsa0.perex.cz (Postfix) with ESMTP id D120C1038FB
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Aug 2007 14:21:31 +0200 (CEST)
Received: from antichrist.local (con132.neoplus.adsl.tpnet.pl [83.31.193.132])
	by mail.jabberpl.org (Postfix) with ESMTP id BCC6A94531
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Aug 2007 14:21:26 +0200 (CEST)
In-Reply-To: <200708021420.26082.bluszcz@jabberpl.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 02 August 2007 14:20:25 Rafa=B3 Zawadzki wrote:
> On Thursday 02 August 2007 11:15:09 Takashi Iwai wrote:
> > Did you read INSTALL file there?  There is ./hgcompile script for
> > convenience.
>
> I read also and tried in this way:
>
> ./hgcompile
> Makefile:24: toplevel.config: No such file or directory
> make: *** Brak regu=B3 do wykonania obiektu `toplevel.config'. Stop.

..............

checking for PCMCIA support... yes
checking for PC9800 support in kernel... no
checking for parallel port support... yes
checking for power management... yes
./configure: line 11726: ALSA_TOPLEVEL_SELECT: command not found
./configure: line 11739: ALSA_TOPLEVEL_DEFINES: command not found
./configure: line 11749: ALSA_TOPLEVEL_OUTPUT: command not found
configure: creating ./config.status
config.status: creating version
config.status: creating Makefile.conf
config.status: WARNING:  Makefile.conf.in seems to ignore the --datarootdir =

setting
config.status: creating snddevices
config.status: creating utils/alsa-driver.spec
config.status: creating utils/buildrpm
config.status: error: cannot find input file: toplevel.config.in

Thanks for you time Takashi, cheers.

-- =

Rafa=B3 bluszcz Zawadzki =

http://my.jabberpl.org - use jabber
http://glam.pl - try secondhand clothes
http://bluszcz.net - my homepage
