From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: Brand-new notebook useless with Linux...
Date: Sun, 11 Sep 2005 21:42:44 -0400
Message-ID: <1126489364.5619.7.camel@mindpipe>
References: <200509091411_MC3-1-A9B0-1C0C@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id E9F881B6
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2005 03:42:46 +0200 (MEST)
In-Reply-To: <200509091411_MC3-1-A9B0-1C0C@compuserve.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-09-09 at 14:09 -0400, Chuck Ebbert wrote:
> In-Reply-To: <1126207905.12697.20.camel@mindpipe>
> 
> On Thu, 08 Sep 2005 at 15:31:44 -0400, Lee Revell wrote:
> 
> > Wait, that sounds like the modem, not the AC97 audio codec.
> >
> > You might be able to get the modem to work with the (proprietary)
> > slmodem software modem, or something.  I wouldn't count on it though.
> > 
> > Does your sound work?
> 
> 
>  Well I'll be...
> 
>  I'd assumed from the (confusing) messages that the sound card was
> not working, but it seems fine.  Shouldn't the error messages from
> atiixp-modem be prefixed with that name instead of "atiixp"?
> 
> Untested patch follows.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

This should be applied IMO.  Can we get it in CVS?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
