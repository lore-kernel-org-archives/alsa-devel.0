From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: You've been selected (aka SPAM)
Date: Thu, 28 Oct 2004 17:00:44 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1098997244.3852.4.camel@krustophenia.net>
References: <E1CMwWX-0000Tt-9j@sc8-sf-list2.sourceforge.net>
	 <20041027225911.68651.qmail@web60802.mail.yahoo.com>
	 <20041028034449.GF1904@zewt.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041028034449.GF1904@zewt.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Glenn Maynard <glenn@zewt.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-10-27 at 23:44 -0400, Glenn Maynard wrote:
> On Wed, Oct 27, 2004 at 03:59:11PM -0700, Tom Watson wrote:
> > Unfortunately the digester (or whatever assembles the group of messages into a
> > digest) DOES NOT forward SpamAssassin Headers.  It treats ALL messages as
> > equal.  This means that the digest traffic has more visable SPAM in it.  I
> 
> The fact that digests are inflexible doesn't make suggestions like "disallow
> thread crossposting" and "ban an entire IP block wholesale" good ones.
> 
> > suspect that what everyone would like (as suggested before) is to get
> > sourceforge to do the filtering.  If it were done there, us users (regular and
> > digest ones) wouldn't need to do it.  Why do the filtering for every subscriber
> > when it can be done once at the source.  Isn't that logical?
> 
> Spam filtering isn't perfect; it's up to each individual to decide for himself
> whether he trusts it not to lose mails (false positives), and putting the spam
> scanning results in a header allows this, instead of forcing it on everyone.
> 

That being said, the original poster does have a point - the result of
this policy decision by Sourceforge, to add headers but not to filter,
is that digest users are stuck with all the spam.  There should probably
be an option to filter spam out of the digests.  SpamAssassin can do
this, you would just pipe the digest through it deleting anything above
a configurable spam score.

You should report this to Sourceforge though, I don't think the people
who could implement this read alsa-devel. 

-- 
Lee Revell <rlrevell@joe-job.com>



-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
