From: Mark Knecht <markknecht@comcast.net>
Subject: Re: HDSP 9652 sync problems cause loud noise in Alsa
	0.9.6
Date: Tue, 07 Oct 2003 05:17:15 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1065529035.1646.9.camel@Wizard.knechthome.com>
References: <1065480915.3438.17.camel@Wizard.knechthome.com>
	 <200310070923.35520.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200310070923.35520.torger@ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-10-07 at 00:23, Anders Torger wrote:
> I think this problem is related to what I mailed about a week ago (no 
> reply). An HDSP master/slave sync problem in current CVS. Thus you are 
> not alone with this type of problem.

Anders,
   Hi. I went back and looked at your post. Sorry I didn't have anything
to offer when you wrote it. Possibly the problems are related. I'm not
sure. I'm not on the latest CVS, so I wasn't at all sure that you were
speaking of anything other than the latest CVS.

   I agree that they may be related. Possibly my noise only happens
continuously when trying to sync to an external 48K source, and possibly
this is just a sign of it never syncing. When I set the Pref. Sync. Ref.
to ADAT1 and use AutoSync I get the noise continuously and the Sync
indicator just goes back and forth between lock and no lock. It never
gets to sync which I presume it should.

   So, Alsa developers, what's this about?

Thanks,
Mark




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
