From: Andy Wingo <wingo@pobox.com>
Subject: Re: Re: Yamaha 754 question...
Date: Fri, 10 May 2002 13:10:03 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020510171003.GA711@jesus>
References: <Pine.LNX.4.10.10205081858500.6735-100000@sorrow.ashke.com> <Pine.LNX.4.10.10205101245090.3651-100000@sorrow.ashke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10205101245090.3651-100000@sorrow.ashke.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm not an expert, but this sounds like something out of a default asoundrc
that involves ttables. To me that means that you would need to use
LD_PRELOAD, etc. For what it's worth, anyway...

regards,

wingo.

On Fri, 10 May 2002, Adam K Kirchhoff wrote:

> 
> No comment on this one? :-(
> 
> Adam
> 
> On Wed, 8 May 2002, Adam K Kirchhoff wrote:
> 
> > 
> > A number of months ago, the possibility of having the rear speakers on the
> > yamaha 754 duplicate the front speakers by default (instead of having to
> > setup .asoundrc to handle the duplication).  
> > 
> > I have a couple quick questions :-)  Would this duplication carry over
> > when using the OSS emualation from Alsa?  And has this development
> > happened yet? 
> > 
> > Adam
> 
> 
> 
> 
> _______________________________________________________________
> 
> Have big pipes? SourceForge.net is looking for download mirrors. We supply
> the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
