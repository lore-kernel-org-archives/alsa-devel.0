From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Re: guitar + sblive + ardour + ladspa effects
Date: Tue, 30 Jul 2002 15:01:00 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D462B9C.2040002@boosthardware.com>
References: <E17ZHUa-0008M8-00@usw-sf-list1.sourceforge.net> <1027977926.10978.104.camel@insanity>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Bob Ham <node@users.sourceforge.net>
Cc: ALSA Development Mailing List <alsa-devel@lists.sourceforge.net>, Ardour Devel Mailing List <ardour-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Bob Ham wrote:

> 
> Err.. I mean have *both* cards in jack.  I have a ~/.asoundrc with
> "platinum51" and "via" devices defined.  I normally do "jackd -d alsa -d
> platinum51".  Doing "jackd -d alsa -d platinum51 -d via" makes it only
> use the via card.  How can I tell it to use both?

There is some info on how to set up your .asoundrc for this operation in 
the alsa wiki.

http://alsa.opensrc.org

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
