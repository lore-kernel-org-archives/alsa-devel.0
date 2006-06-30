From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002188]: Alsa mixer lack of some
	functions
Date: Fri, 30 Jun 2006 11:05:28 +0200
Message-ID: <1d843b7f946e569a0d38a996d7b29806@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0744013D
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 11:05:28 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2188> 
======================================================================
Reported By:                Cimmo
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   2188
Category:                   alsamixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-07-2006 16:56 CEST
Last Modified:              06-30-2006 11:05 CEST
======================================================================
Summary:                    Alsa mixer lack of some functions
Description: 
Is it possible to add to the alsa-mixer the possibility to change these
things:

- dolby surround configurations: 2.0, 2.1, 4.0, 4.1, 5.1, 7.1 and the
possibility to duplicate front sound to the rear speakers.
- modify high and basses

best things is changes are immediatelly available without relogging.
These feature are missing to linux community that have always to trouble
with configuration files.

thanx for attention
Marco
======================================================================

----------------------------------------------------------------------
 rlrevell - 06-28-06 17:30 
----------------------------------------------------------------------
No idea.  It must be a kaffeine bug.  Try another player, like VLC or
mplayer.

----------------------------------------------------------------------
 Cimmo - 06-30-06 11:05 
----------------------------------------------------------------------
tried vlc, still no surround, there is a problem somewhere... :(

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-06 16:56 Cimmo          New Issue                                    
06-08-06 02:52 Raymond        Note Added: 0010104                          
06-08-06 11:22 Cimmo          Note Added: 0010111                          
06-09-06 07:08 Raymond        Note Added: 0010134                          
06-09-06 11:20 Cimmo          Note Added: 0010139                          
06-24-06 10:39 Cimmo          Note Added: 0010471                          
06-24-06 17:04 rlrevell       Note Added: 0010476                          
06-24-06 17:11 Cimmo          Note Added: 0010477                          
06-24-06 17:20 rlrevell       Note Added: 0010478                          
06-24-06 18:01 Cimmo          File Added: alsa                             
06-24-06 18:02 Cimmo          Note Added: 0010479                          
06-24-06 18:11 rlrevell       Note Added: 0010480                          
06-24-06 18:26 Cimmo          Note Added: 0010482                          
06-24-06 18:33 rlrevell       Note Added: 0010483                          
06-24-06 18:37 Cimmo          File Added: alsa-test                        
06-24-06 18:38 Cimmo          Note Added: 0010484                          
06-24-06 18:55 rlrevell       Note Added: 0010485                          
06-24-06 19:05 Cimmo          Note Added: 0010486                          
06-24-06 19:17 rlrevell       Note Added: 0010487                          
06-25-06 04:32 Raymond        Note Added: 0010498                          
06-25-06 04:33 Raymond        Note Edited: 0010498                         
06-25-06 12:16 Cimmo          File Added: alsamixer.png                    
06-25-06 12:18 Cimmo          Note Added: 0010506                          
06-25-06 12:20 Cimmo          Note Edited: 0010506                         
06-25-06 14:05 Raymond        Note Added: 0010508                          
06-25-06 14:46 Cimmo          File Added: pcm                              
06-25-06 14:46 Cimmo          File Added: cards                            
06-25-06 14:47 Cimmo          Note Added: 0010509                          
06-25-06 15:24 Raymond        Note Added: 0010511                          
06-25-06 15:26 Raymond        Note Edited: 0010511                         
06-25-06 15:32 Cimmo          Note Added: 0010512                          
06-25-06 18:29 Cimmo          Note Edited: 0010512                         
06-25-06 18:30 Cimmo          Note Edited: 0010512                         
06-25-06 18:32 Cimmo          Note Edited: 0010512                         
06-27-06 09:01 Raymond        Note Added: 0010569                          
06-27-06 09:29 Raymond        Note Edited: 0010569                         
06-27-06 18:56 Cimmo          Note Added: 0010597                          
06-27-06 19:07 rlrevell       Note Added: 0010598                          
06-28-06 04:25 Raymond        Note Added: 0010606                          
06-28-06 04:33 rlrevell       Note Added: 0010607                          
06-28-06 10:45 Cimmo          Note Added: 0010612                          
06-28-06 10:46 Cimmo          Note Edited: 0010612                         
06-28-06 16:15 rlrevell       Note Added: 0010619                          
06-28-06 16:36 Cimmo          Note Added: 0010621                          
06-28-06 17:30 rlrevell       Note Added: 0010623                          
06-30-06 11:05 Cimmo          Note Added: 0010725                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
