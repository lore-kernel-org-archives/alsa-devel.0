From: Georgi Georgiev <chutz@gg3.net>
Subject: Re: Re: Broken AC3 on EMU10K1 since July 2-nd
Date: Thu, 30 Sep 2004 23:48:57 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040930144856.GA18220@lion.gg3.net>
References: <20040927160314.GA16100@lion.gg3.net> <20040927162024.GA5768@lion.gg3.net> <1096311039.7203.96.camel@krustophenia.net> <20040928051034.GA9175@lion.gg3.net> <1096388641.2067.7.camel@krustophenia.net> <s5hzn3az7bo.wl@alsa2.suse.de> <s5hr7okxe1x.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hr7okxe1x.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

maillog: 30/09/2004-12:10:34(+0200): Takashi Iwai types
> At Tue, 28 Sep 2004 18:28:27 +0200,
> I wrote:
> > 
> > > OK, the problem is almost certainly the introduction of pcm_indirect for
> > > the FX8010 PCM.  Takashi-san, do you agree?
> > 
> > Most likely.  I'll take a look.
> 
> The attached oneliner fixes this bug.
> Already applied to CVS.

Not sure what the proper procedure is, so I will just confirm that
latest CVS works now.

-- 
*>   Georgi Georgiev   *> You will be successful in love.              *>
<*    chutz@gg3.net    <*                                              <*
*>  +81(90)6266-1163   *>                                              *>


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
