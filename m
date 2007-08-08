From: Frank Barknecht <fbar@footils.org>
Subject: Re: [alsa-devel] Website to Wiki migration
Date: Wed, 8 Aug 2007 20:31:57 +0200
Message-ID: <20070808183156.GB13952@fliwatut.scifi>
References: <200708081342.26827.linux@audioscience.com>
	<s5htzraxcor.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5htzraxcor.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: alsa-user@lists.sourceforge.net, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hallo,
Takashi Iwai hat gesagt: // Takashi Iwai wrote:

> At Wed, 08 Aug 2007 13:42:26 +1200,
> Eliot Blennerhassett wrote:
> > * User added comments in the soundcard matrix are referenced.  (Is there any 
> > way to find out which modules in the matrix have user comments attached so 
> > that they can be copied across to the wiki?)
> 
> Oh these are also the stuff we need to clean up.
> Most of comments there are outdated.

I also think, the standard entry on setting up an .asoundrc should be
completely removed from the module pages. The asoundrc example there
is rather useless anyway. Most users for most cards don't need an
asoundrc, so telling them things like "Some very useful applications
will not work without it" is misleading - and wrong, or are there
useful applications that don't work without an asoundrc? ;) I'd say,
that part should just be deleted except for cards that actually need an
asoundrc, like maybe the RME.

Ciao
-- 
 Frank Barknecht                 _ ______footils.org_ __goto10.org__

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
