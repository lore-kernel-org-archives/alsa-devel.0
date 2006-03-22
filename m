From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: More detailed Acer (Intel HDA)
Date: Wed, 22 Mar 2006 04:38:47 -0500
Message-ID: <1143020328.1792.66.camel@mindpipe>
References: <200603220041.k2M0f8uA011967@auster.physics.adelaide.edu.au>
	 <1142988679.4532.197.camel@mindpipe>  <4420FB3E.3030804@akl.lt>
	 <1143012964.1792.61.camel@mindpipe>  <44210F4D.8070508@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <44210F4D.8070508@akl.lt>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rimas Kudelis <rq@akl.lt>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-03-22 at 10:48 +0200, Rimas Kudelis wrote:
> Hi,
> >>>> On these Acer laptops the evidence thus far indicates that there is no
> >>>> audio connection between the CD drive and the sound card. 
> >>>>         
> >>> I haven't seen any evidence at all, just speculation, apparently no one
> >>> is willing to try Windows to verify this.  Until there's some evidence
> >>> IMHO the CD control should stay.
> >>>       
> >> The fact is that the CD control doesn't work now. And I didn't manage to 
> >> find a way to make any control in the test model influence CD playback 
> >> volume. Why would you want a non-working control to stay?
> >>     
> > Because it may work on some other laptops, and it's better for people to
> > be able to test it.
> >   
> It may or may not work. And people can still use the test model for testing.
> 

Yes exactly, and a missing control is much worse than a control that
does nothing.

There just needs to be some shred of evidence beyond my speculation
about the CD pins not being connected before controls are removed from a
driver.

Lee 



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
