From: Ryan Pavlik <rpav@mephle.com>
Subject: Re: ALSA sequencer changes?
Date: Sun, 14 Dec 2003 17:22:41 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031214172241.605958cd.rpav@mephle.com>
References: <E1AVNWF-00073D-OC@sc8-sf-list2.sourceforge.net>
	<200312150200.38251.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312150200.38251.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Dec 2003 02:03:53 +0100
Pedro Lopez-Cabanillas <plcl@telefonica.net> wrote:

> > The problem isn't getting 0's for time (got that one sorted awhile
> > back, but never integrated the fix)---the problem is I'm not
> > getting anything.
> >
> > Anyhow, just wondering what's new or different, or if it's
> > something else I missed.
> 
> No problems here with 1.0.0rc2. Your test reports events and times
> like before. Try using other client/port, check your cables,
> interfaces, etc...

Hmm, odd... I finally got it working though.  I think the MTP/AV
driver may have needed reloading or something.  I thought it was a bit
more forgiving, but I may have just had the mtpav on all the time.

thanks,

-- 
Ryan Pavlik <rpav@mephle.com>

"Mr Pibb, Dr Pepper, I'm on to you..." - 8BT


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
