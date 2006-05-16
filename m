From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: question about closed source alsa driver
Date: Tue, 16 May 2006 11:26:00 -0400
Message-ID: <1147793161.13948.117.camel@mindpipe>
References: <d39e2e70605160318meac7c91g40bb9cd7a85c0665@mail.gmail.com>
	 <4469CE12.6090701@findus.dhs.org>
	 <d39e2e70605160637g153bd27ei3cc3dc28df59dba1@mail.gmail.com>
	 <1147791320.13948.111.camel@mindpipe>  <4469EE3B.7010600@instant.com.br>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4469EE3B.7010600@instant.com.br>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-05-16 at 12:22 -0300, Juan Carlos Castro y Castro wrote:
> Lee Revell wrote:
> 
> >On Tue, 2006-05-16 at 17:37 +0400, Sergey Kolosov wrote:
> >  
> >
> >>Whether me interests if I shall write closed source alsa driver there
> >>will be it violations gpl?
> >>    
> >>
> >No you cannot.  The ALSA driver core is GPL so all drivers must be GPL.
> >
> >Why do you need to hide the hardware details?  It's just a sound card.
> >  
> >
> It may be that his bosses are not as enlightened as him... you and I 
> understand that publishing the hardware interface to a sound card hardly 
> gives away crucial secrets, but PHBs might not. Maybe some evangelism is 
> in order.
> 

They just need to survey the market - I would think it would be enough
to see that Intel, Via, M-Audio, RME, Creative, and countless other
vendors all have provided open source ALSA drivers.

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
